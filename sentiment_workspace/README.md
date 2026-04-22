

## Overview
This is a web-based tool built using the Django framework that performs natural language processing on user-provided text. The application calculates the sentiment polarity (how positive or negative the text is) and the subjectivity (how much opinion vs. fact is present) using the TextBlob library.

## Project Structure
- `sentiment_project/`: Core configuration, settings, and routing.
- `analyzer/`: The primary application logic, sentiment processing, and UI templates.
- `requirements.txt`: List of Python dependencies.
- `.env`: Local environment variables for security and configuration.
- `manage.py`: Django's command-line utility for administrative tasks.

## Prerequisites
Ensure you have the following installed on your system:
- Python 3.8 or higher
- pip (Python package manager)

## Installation and Setup

 **Navigate to the Project Directory**
   Open your terminal and enter the project folder:
   ```bash
   cd sentiment_workspace
Set Up a Virtual Environment
    It is recommended to use a virtual environment to keep dependencies isolated:
    Bash

    python3 -m venv venv
    source venv/bin/activate
    # On Windows: venv\\Scripts\\activate

    Install Dependencies
    Install the required Python packages:
    Bash

    pip install -r requirements.txt

    Environment Configuration
    The project includes a .env file for settings. Ensure the SECRET_KEY and DEBUG mode are set appropriately for your environment. Refer to .env.example for the template.

    Initialize the Database
    Apply the migrations to set up the internal Django database:
    Bash

    python manage.py migrate

Running the Application

    Start the Server
    Run the development server with the following command:
    Bash

    python manage.py runserver

    Access the Interface
    Open your web browser and go to:
    http://127.0.0.1:8000
