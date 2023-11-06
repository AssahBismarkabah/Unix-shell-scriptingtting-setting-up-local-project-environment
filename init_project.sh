#!/bin/bash

# Define variables
PROJECT_NAME=""
PROJECT_DIR=""
PYTHON_VERSION="3.10"
VIRTUALENV_DIR=""
BASH_VERSION="5.1"

# Prompt the user for the project name and directory
echo "Enter the project name: "
read PROJECT_NAME

#!/bin/bash

# Make the script globally accessible
printf "Making the script globally accessible...\n"
mkdir -p ~/bin
echo "export PATH=\$PATH:~/.bin" >> ~/.bashrc
mv init_project.sh ~/bin
chmod +x ~/bin/init_project.sh
source ~/.bashrc

# Reload the shell profile
printf "Reloading the shell profile...\n"
printf "Run the following command to reload the shell profile:\n"
echo "source ~/.bashrc"

PROJECT_DIR="/home/assah/scripting_automating_projects/$PROJECT_NAME"

# Check if the project directory exists and create it if it does not
if [ ! -d "$PROJECT_DIR" ]; then
    mkdir -p "$PROJECT_DIR"
fi

# Prompt the user to select a project type (Python or Bash)
echo "Select a project type:"
echo "1. Python project"
echo "2. Bash project"
read PROJECT_TYPE

# Set up the virtual environment for Python projects if that option is chosen
if [ "$PROJECT_TYPE" == "1" ]; then
    VIRTUALENV_DIR="$PROJECT_DIR/venv"

    if [ ! -d "$VIRTUALENV_DIR" ]; then
        python3 -m venv "$VIRTUALENV_DIR"
    fi

    source "$VIRTUALENV_DIR/bin/activate"

    # Prompt the user to install the required Python packages
    echo "Do you want to install the required Python packages? (y/n)"
    read INSTALL_PYTHON_PACKAGES

    if [ "$INSTALL_PYTHON_PACKAGES" == "y" ]; then
        pip install -r requirements.txt
    fi
fi

# Generate a README file with run instructions for Bash projects
if [ "$PROJECT_TYPE" == "2" ]; then
    README_FILE="$PROJECT_DIR/README.md"

    cat << EOF > "$README_FILE"
## ${PROJECT_NAME} README

This project is a Bash project. To run the scripts in this project, you can use the following commands:

**With execution permissions:**

\`\`\`
./script_name.sh
\`\`\`

**Without execution permissions:**

\`\`\`
bash script_name.sh
\`\`\`

EOF
fi

