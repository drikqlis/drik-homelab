#!/bin/bash

# Specify the Python version you want to use (optional)
PYTHON_VERSION="3.12"

# Get the parent directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

# Specify the name for your virtual environment
VENV_NAME="venv"

# Create the virtual environment
python$PYTHON_VERSION -m venv "$PARENT_DIR/$VENV_NAME"

# Create the virtual environment
python$PYTHON_VERSION -m venv "$VENV_NAME"

# Activate the virtual environment
source "$VENV_NAME/bin/activate"

# Upgrade pip
pip install --upgrade pip

# Install pip requirements from the parent directory
pip install -r "$PARENT_DIR/requirements.txt"

# Install ansible requeriements
ansible-galaxy install -r "$PARENT_DIR/requirements.yml"

# Print success message
echo "Python virtual environment '$VENV_NAME' has been created and activated."
