#!/bin/bash

# 1. Create the main workspace and directory structure
echo "Creating project directories..."
mkdir -p sentiment_workspace/sentiment_project
mkdir -p sentiment_workspace/analyzer/templates/analyzer
cd sentiment_workspace

# 2. Create requirements.txt
echo "Writing requirements.txt..."
cat << 'EOF' > requirements.txt
Django>=4.2,<5.0
textblob==0.17.1
python-dotenv==1.0.0
EOF

# 3. Create .env files
echo "Writing environment files..."
cat << 'EOF' > .env.example
SECRET_KEY=your-insecure-default-key-for-dev
DEBUG=True
ALLOWED_HOSTS=127.0.0.1,localhost
EOF

cat << 'EOF' > .env
SECRET_KEY=django-insecure-v(s*3v$w*y9%_#=^!z@p4&k(f%7&0!_9=m-c$b@q+y
DEBUG=True
ALLOWED_HOSTS=127.0.0.1,localhost
EOF

# 4. Create manage.py
echo "Writing manage.py..."
cat << 'EOF' > manage.py
#!/usr/bin/env python
import os
import sys

def main():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'sentiment_project.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)

if __name__ == '__main__':
    main()
EOF

# 5. Create core Django files
echo "Writing core Django settings and URLs..."
touch sentiment_project/__init__.py

cat << 'EOF' > sentiment_project/settings.py
import os
from pathlib import Path
from dotenv import load_dotenv

load_dotenv()

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = os.getenv('SECRET_KEY', 'default-key-if-missing')
DEBUG = os.getenv('DEBUG', 'False').lower() in ('true', '1', 't')
ALLOWED_HOSTS = os.getenv('ALLOWED_HOSTS', '').split(',')

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'analyzer',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'sentiment_project.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'sentiment_project.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

STATIC_URL = 'static/'
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
EOF

cat << 'EOF' > sentiment_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('analyzer.urls')),
]
EOF

cat << 'EOF' > sentiment_project/wsgi.py
import os
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'sentiment_project.settings')
application = get_wsgi_application()
EOF

# 6. Create analyzer app files
echo "Writing analyzer app files..."
touch analyzer/__init__.py

cat << 'EOF' > analyzer/apps.py
from django.apps import AppConfig

class AnalyzerConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'analyzer'
EOF

cat << 'EOF' > analyzer/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
EOF

cat << 'EOF' > analyzer/views.py
from django.shortcuts import render
from textblob import TextBlob

def index(request):
    context = {}
    
    if request.method == 'POST':
        user_text = request.POST.get('user_text', '')
        
        if user_text.strip():
            blob = TextBlob(user_text)
            polarity = blob.sentiment.polarity
            subjectivity = blob.sentiment.subjectivity
            
            if polarity > 0.05:
                sentiment_class = 'Positive'
                color_theme = 'text-green-600 bg-green-100 border-green-200'
            elif polarity < -0.05:
                sentiment_class = 'Negative'
                color_theme = 'text-red-600 bg-red-100 border-red-200'
            else:
                sentiment_class = 'Neutral'
                color_theme = 'text-gray-600 bg-gray-100 border-gray-200'
                
            context = {
                'analyzed': True,
                'user_text': user_text,
                'sentiment_class': sentiment_class,
                'polarity': round(polarity, 4),
                'subjectivity': round(subjectivity, 4),
                'color_theme': color_theme
            }
        else:
            context['error'] = "Please enter some text to analyze."
            
    return render(request, 'analyzer/index.html', context)
EOF

# 7. Create HTML Template
echo "Writing HTML template..."
cat << 'EOF' > analyzer/templates/analyzer/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Text Sentiment Analyzer</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800 font-sans selection:bg-indigo-200 selection:text-indigo-900">
    <main class="max-w-4xl mx-auto pt-16 pb-12 px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-10">
            <h1 class="text-4xl font-extrabold tracking-tight text-slate-900 sm:text-5xl">
                Sentiment Analysis Tool
            </h1>
            <p class="mt-4 text-lg text-slate-600">
                Enter your text below to analyze its emotional tone, polarity, and subjectivity.
            </p>
        </div>
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="p-6 sm:p-10">
                <form method="POST" action="{% url 'index' %}">
                    {% csrf_token %}
                    <label for="user_text" class="block text-sm font-medium text-slate-700 mb-2">Text to Analyze</label>
                    <textarea 
                        id="user_text" name="user_text" rows="5" 
                        class="block w-full rounded-xl border-slate-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-base p-4 border bg-slate-50" 
                        placeholder="Type or paste your text here..." required>{% if user_text %}{{ user_text }}{% endif %}</textarea>
                    
                    {% if error %}
                        <p class="mt-2 text-sm text-red-600">{{ error }}</p>
                    {% endif %}
                    <div class="mt-6 flex justify-end">
                        <button type="submit" class="inline-flex items-center rounded-lg border border-transparent bg-indigo-600 px-6 py-3 text-base font-medium text-white shadow-sm hover:bg-indigo-700 transition-colors">
                            Analyze Text
                        </button>
                    </div>
                </form>
            </div>
            
            {% if analyzed %}
            <div class="border-t border-slate-200 bg-slate-50 p-6 sm:p-10">
                <h3 class="text-lg font-semibold text-slate-900 mb-6">Analysis Results</h3>
                <div class="grid grid-cols-1 gap-6 sm:grid-cols-3">
                    <div class="rounded-xl border p-5 flex flex-col items-center justify-center text-center {{ color_theme }}">
                        <span class="text-sm font-medium uppercase tracking-wider mb-1 opacity-80">Overall Tone</span>
                        <span class="text-2xl font-bold">{{ sentiment_class }}</span>
                    </div>
                    <div class="rounded-xl border border-slate-200 bg-white p-5 flex flex-col items-center justify-center text-center shadow-sm">
                        <span class="text-sm font-medium text-slate-500 uppercase tracking-wider mb-1">Polarity Score</span>
                        <span class="text-2xl font-bold text-slate-800">{{ polarity }}</span>
                        <span class="text-xs text-slate-400 mt-2">-1 (Negative) to 1 (Positive)</span>
                    </div>
                    <div class="rounded-xl border border-slate-200 bg-white p-5 flex flex-col items-center justify-center text-center shadow-sm">
                        <span class="text-sm font-medium text-slate-500 uppercase tracking-wider mb-1">Subjectivity Score</span>
                        <span class="text-2xl font-bold text-slate-800">{{ subjectivity }}</span>
                        <span class="text-xs text-slate-400 mt-2">0 (Objective) to 1 (Subjective)</span>
                    </div>
                </div>
            </div>
            {% endif %}
        </div>
    </main>
</body>
</html>
EOF

# 8. Set up Virtual Environment and Install Dependencies
echo "Setting up Virtual Environment..."
python3 -m venv venv

echo "Activating Virtual Environment and installing dependencies..."
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# 9. Run Database Migrations
echo "Applying database migrations..."
python manage.py migrate

echo "============================================================"
echo "Setup complete! All files generated in 'sentiment_workspace'."
echo ""
echo "To start your application, run the following commands:"
echo "  cd sentiment_workspace"
echo "  source venv/bin/activate"
echo "  python manage.py runserver"
echo ""
echo "Then, open http://127.0.0.1:8000 in your browser."
echo "============================================================"
