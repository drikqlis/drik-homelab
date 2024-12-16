import requests
import argparse
from datetime import datetime, timedelta

# Define a function to fetch post counts for a character over a specific time period
def fetch_post_count(api_url, character_id, date_from, date_to):
    try:
        response = requests.get(f"{api_url}/api/CharacterPosts/{character_id}", headers={"DateFrom": date_from, "DateTo": date_to})
        response.raise_for_status()
        return int(response.text)  # API returns a plain int value
    except requests.RequestException as e:
        print(f"Error fetching data for character {character_id}: {e}")
        return 0

# Define a function to calculate date_from and date_to from periods in days
def calculate_date_ranges(days_list):
    date_ranges = []
    now = datetime.now()
    for days in days_list:
        date_to = now.strftime("%Y-%m-%dT%H:%M:%S.%fZ")
        date_from = (now - timedelta(days=int(days))).strftime("%Y-%m-%dT%H:%M:%S.%fZ")
        date_ranges.append((days, f"{date_from},{date_to}"))
    return date_ranges

# Define a function to gather and rank post counts for multiple characters over multiple time periods
def gather_post_counts(api_url, characters, time_periods, is_days):
    results = {}

    for period in time_periods:
        if is_days:
            days, range_str = period
            date_from, date_to = range_str.split(",")
            period_key = f"{days}"
        else:
            date_from, date_to = period.split(",")
            period_key = f"{date_from} do {date_to}"

        period_results = []

        for character_id, character_name in characters.items():
            post_count = fetch_post_count(api_url, character_id, date_from, date_to)
            period_results.append((character_name, post_count))

        # Sort by post count in descending order
        period_results.sort(key=lambda x: x[1], reverse=True)
        results[period_key] = period_results

    return results

# Define a function to display the results
def display_rankings(results, is_days):
    output = ["**✏️ Przypomnienie o odpisach 🖋️**"]
    for period, rankings in results.items():
        if is_days:
            output.append(f"*Ranking odpisów - ostatnie {period} dni:*")
        else:
            output.append(f"*Ranking odpisów - od {period}:*")

        for rank, (character_name, post_count) in enumerate(rankings, start=1):
            if rank == 1:
                output.append(f"||{rank}. {character_name}: {post_count}")
            elif rank == len(rankings):
                output.append(f"{rank}. {character_name}: {post_count}||")
            else:
                output.append(f"{rank}. {character_name}: {post_count}")
    return "\n".join(output)

# Define a function to send a message using Signal CLI REST API
def send_signal_message(signal_api_url, phone_number, recipients, message):
    try:
        data = {
            "message": message,
            "number": phone_number,
            "recipients": recipients,
            "text_mode": "styled"
        }
        response = requests.post(f"{signal_api_url}/v2/send", json=data)
        response.raise_for_status()
        print("Message sent successfully!")
    except requests.RequestException as e:
        print(f"Error sending message: {e}")

# Main function to parse arguments and execute the script
def main():
    parser = argparse.ArgumentParser(description="Gather and rank character post counts over multiple time periods.")
    parser.add_argument("--api_url", required=True, help="Base URL of the API endpoint.")
    parser.add_argument("--characters", nargs="+", required=True, help="List of character IDs and names in the format id:name (e.g., 1:John 2:Jane).")
    parser.add_argument("--time_periods", nargs="+", help="List of time periods (date_from,date_to) to fetch post counts for.")
    parser.add_argument("--days", nargs="+", type=int, help="List of time periods in days (e.g., 7 30) starting from now.")
    parser.add_argument("--signal_api_url", help="Base URL of the Signal CLI REST API.")
    parser.add_argument("--phone_number", help="Phone number registered with Signal.")
    parser.add_argument("--recipients", nargs="+", help="List of recipient phone numbers.")
    parser.add_argument("--send", action="store_true", help="Send the output as a Signal message.")

    args = parser.parse_args()

    api_url = args.api_url
    characters = {char.split(":")[0]: char.split(":")[1] for char in args.characters}

    if args.days:
        time_periods = calculate_date_ranges(args.days)
        is_days = True
    elif args.time_periods:
        time_periods = args.time_periods
        is_days = False
    else:
        print("Error: You must provide either --time_periods or --days.")
        return

    results = gather_post_counts(api_url, characters, time_periods, is_days)
    output = display_rankings(results, is_days)
    print(output)

    if args.send:
        if not (args.signal_api_url and args.phone_number and args.recipients):
            print("Error: To send a message, you must provide --signal_api_url, --phone_number, and --recipients.")
            return

        send_signal_message(args.signal_api_url, args.phone_number, args.recipients, output)

if __name__ == "__main__":
    main()
