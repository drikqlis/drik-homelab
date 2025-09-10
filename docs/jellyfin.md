# 📔 Authentik
### Reset your password

After receiving email for password reset go to the link provided in the message:

![authentik-step-1](https://github.com/drikqlis/drik-homelab/assets/19647553/d298a948-0928-4f7f-bed5-c41b1ac6fffe)

You should see Authentik site with Drik.IT logo. Provide your email address and type your new password twice.

![authentik-step-2](https://github.com/drikqlis/drik-homelab/assets/19647553/e3ab0b68-b01f-4e0a-8008-308767998fef)

### Configure second factor

Next up is Multi-Factor authentication. It is required to enchance security. Select **TOTP Device** and scan QR code using two-factor mobile app of your choice.
If you don't have one simply download **Google Authenticator** from PlayStore on your phone and follow instructions to scan QR code. Next, retype code from your code into Authentik and continue.

![image](https://github.com/drikqlis/drik-homelab/assets/19647553/70aa3cda-540c-417a-893b-94207fa0e766)

You should be greated with homepage similar to the one above. Great, first part complete!

# 🎥 Jellyfin

### Go to Authentik

To login to Jellyfin on PC, phone or TV app we have to do some magic. First go to the homepage we visited in previous step.
You can go there by following this link on PC or your phone: https://auth.drik.it

### Login to Jellyfin in web browser

Press the big Jellyfin button in Authentik and you should get automatically logged into Jellyfin in your browser.
Leave this page open, we will need it later.

### Installing Jellyfin on PC, TV or a phone
However we would like to login Jellyfin app on your phone, PC or TV! First we must install the app.

<details>
  <summary><b>PC</b></summary>
Go to this link: https://github.com/jellyfin/jellyfin-media-player/releases and you will see something like this:

![image](https://github.com/user-attachments/assets/e449047d-1b9f-466d-ba2d-00e11fc01dd1)

In the first box marked as latest we find the installer for our system.
In almost all cases it's name will end in `windows-x64.exe` like here:

![image](https://github.com/user-attachments/assets/ad4236f5-e93f-4100-8a1f-87e33c3f0ecf)

Click it and an installer should download to our PC:

![image](https://github.com/user-attachments/assets/442e6406-aff1-4010-96e2-ef64de4006ef)

Open the installer and you should see this screen. Press install:

![image](https://github.com/user-attachments/assets/531ae9a5-a7fb-48c2-ae08-d598a1775298)

When it finishes press Launch. Installation complete!

![image](https://github.com/user-attachments/assets/d50c2f02-014b-4085-9b2d-b153e6042bf1)
</details>

<details>
  <summary><b>Android</b></summary>

Go to the Play Store and search for Jellyfin. Press install. Done!

</details>

<details>
  <summary><b>iOS</b></summary>

Go to the App Store and search for Jellyfin. Press install. Done!
</details>

<details>
  <summary><b>Android TV</b></summary>

Go to the Play Store and search for Jellyfin. There should be an app called Jellyfin for Android TV. Press install. Done!
</details>

### Login to Jellyfin apps on your PC, phone or TV
After you installed the apps you must login in them. To do that go to your app of choice and press **Use Quick Connect** button:

![image](https://github.com/drikqlis/drik-homelab/assets/19647553/1ab4b40d-9270-403a-adf7-73e9ac112ddc)

It should show you a secret code, like this:

![image](https://github.com/drikqlis/drik-homelab/assets/19647553/3ed90ee4-34c2-41f0-ab99-a57ed1b6ef87)

### Back to the browser

Armed with this code go back to Jellyfin in your browser to which we logged in previous step, then press ![image](https://github.com/drikqlis/drik-homelab/assets/19647553/dec7fe89-c076-431a-b7bf-e26aff50ae41) button in top right corner.
You should see a menu. We are looking for Quick Connect entry:

![image](https://github.com/drikqlis/drik-homelab/assets/19647553/d48a6312-d56d-4e34-8eb6-d9783285407a)

Press it and type in your super secret code from the app, then press authorize. Voila! You should now be logged in your app.
Repeat for every device you want to connect.

