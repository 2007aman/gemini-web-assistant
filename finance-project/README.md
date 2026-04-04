Finance Tracker Backend

This is a Django-based API for tracking personal finances. It handles income and expense records, provides a basic analytics summary, and includes built-in roles for security.
Setup Instructions

    Environment:
    Create and activate a virtual environment:
    Bash

    python -m venv venv
    source venv/bin/activate  # On Windows: venv\Scripts\activate

    Dependencies:
    Install the required packages:
    Bash

    pip install -r requirements.txt

    Database:
    Run migrations to set up the SQLite database:
    Bash

    python manage.py migrate

    Superuser:
    I have already included a script to create an admin, but you can create your own:
    Bash

    python manage.py createsuperuser

Testing with Sample Data

To see the analytics and filtering working immediately without manual entry, run this command to load the test data I prepared:
Bash

python manage.py loaddata seed_data.json

How to Use the API?

    Run Server: python manage.py runserver

    Admin Panel: http://127.0.0.1:8000/admin/ (Use this to add/edit users and transactions).

    Transactions List: http://127.0.0.1:8000/api/transactions/

    Finance Summary: http://127.0.0.1:8000/api/analytics/

Key Features Implemented

    Validation: The system prevents saving any transaction with a negative or zero amount.

    Filtering: You can filter results directly in the URL, for example: /api/transactions/?category=Salary.

    Permissions: * Admins have full control (Create, Update, Delete).

        Viewers/Analysts can only read the data (GET requests).

    Analytics Logic: The analytics endpoint calculates total income, total expenses, and the current net balance on the fly.

Design Choices

    SQLite: Chosen for portability so the project runs immediately without external database configuration.

    REST Structure: Used Django Rest Framework to keep the backend decoupled, making it easy to connect any frontend or mobile app later.

    Security: Focused on backend-level validation to ensure data integrity even if the frontend is bypassed.
