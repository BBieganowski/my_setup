basevenv() {
    local venv_name=".venv"
    local python_version="python3.11"

    # Check if Python 3.11 is available
    if ! command -v $python_version &> /dev/null; then
        echo "Error: $python_version is not installed or not in PATH"
        return 1
    fi

    # Create virtual environment
    $python_version -m venv $venv_name

    # Activate virtual environment
    source $venv_name/bin/activate

    # Install base packages
    pip install pandas numpy matplotlib jupyter

    # Install VS Code Jupyter extension requirements
    pip install ipykernel

    # Check if requirements.txt exists and install if it does
    if [ -f "requirements.txt" ]; then
        echo "Found requirements.txt. Installing packages..."
        pip install -r requirements.txt
    fi

    echo "Virtual environment '$venv_name' created and activated with base packages installed."
}

activate_venv() {
    if [ -d ".venv" ]; then
        if [[ "$VIRTUAL_ENV" != "" ]]; then
            deactivate
        fi
        source .venv/bin/activate
        echo "Activated virtual environment '.venv'"
    else
        echo "No '.venv' directory found in the current folder."
    fi
}