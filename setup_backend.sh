#!/bin/bash

echo "🚀 Bootstrapping the QSkill Gemini Assistant project..."

# 1. Create Directories
mkdir -p qskill-gemini-bot/templates
cd qskill-gemini-bot || exit

# 2. Create requirements.txt
cat << 'EOF' > requirements.txt
flask==3.0.0
google-generativeai==0.4.1
python-dotenv==1.0.0
requests==2.31.0
EOF

# 3. Create .env.example
cat << 'EOF' > .env.example
# Gemini API Configuration
GEMINI_API_KEY=your_gemini_api_key_here

# Google Custom Search API Configuration (for real-time data)
GOOGLE_SEARCH_API_KEY=your_google_search_api_key_here
SEARCH_ENGINE_ID=your_search_engine_cx_id_here
EOF

# 4. Create .env
cat << 'EOF' > .env
GEMINI_API_KEY=your_gemini_api_key_here
GOOGLE_SEARCH_API_KEY=your_google_search_api_key_here
SEARCH_ENGINE_ID=your_search_engine_cx_id_here
EOF

# 5. Create app.py
cat << 'EOF' > app.py
import os
import requests
from flask import Flask, render_template, request, jsonify
from dotenv import load_dotenv
import google.generativeai as genai

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Configure the Gemini API
genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

def google_search(query: str) -> str:
    """
    Perform a Google Search to retrieve real-time information.
    Gemini will automatically call this function when it needs up-to-date data.
    """
    api_key = os.getenv("GOOGLE_SEARCH_API_KEY")
    cx = os.getenv("SEARCH_ENGINE_ID")

    if not api_key or not cx or api_key == "your_google_search_api_key_here":
        return "Search API keys are not configured. Please set GOOGLE_SEARCH_API_KEY and SEARCH_ENGINE_ID."

    url = f"https://www.googleapis.com/customsearch/v1?key={api_key}&cx={cx}&q={query}"
    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()
        results = data.get("items", [])
        
        if not results:
            return "No search results found."
            
        snippets = [f"Title: {item['title']}\nSnippet: {item['snippet']}" for item in results[:3]]
        return "\n\n".join(snippets)
    except Exception as e:
        return f"Search failed: {str(e)}"

# Initialize the Gemini model and bind the search tool
model = genai.GenerativeModel(
    model_name='gemini-1.5-flash',
    tools=[google_search]
)

# Start a chat session (this automatically handles conversation history)
chat_session = model.start_chat(enable_automatic_function_calling=True)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/api/chat", methods=["POST"])
def chat():
    user_message = request.json.get("message")
    if not user_message:
        return jsonify({"error": "Message is required"}), 400

    try:
        response = chat_session.send_message(user_message)
        return jsonify({"response": response.text})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True, port=5000)
EOF

# 6. Create templates/index.html
cat << 'EOF' > templates/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Assistant | QSkill</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .chat-container::-webkit-scrollbar { width: 6px; }
        .chat-container::-webkit-scrollbar-thumb { background-color: #4b5563; border-radius: 10px; }
    </style>
</head>
<body class="bg-gray-950 text-gray-100 font-sans h-screen flex flex-col items-center justify-center p-4">

    <div class="w-full max-w-4xl bg-gray-900 rounded-2xl shadow-2xl overflow-hidden flex flex-col h-[85vh] border border-gray-800">
        <div class="bg-gray-950 p-4 border-b border-gray-800 flex justify-between items-center px-6">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-indigo-600 rounded-full flex items-center justify-center shadow-lg shadow-indigo-500/20">
                    <i class="fa-solid fa-bolt text-xl text-white"></i>
                </div>
                <div>
                    <h1 class="text-xl font-bold tracking-tight text-white">Gemini Web Assistant</h1>
                    <p class="text-xs text-emerald-400 flex items-center gap-1.5 mt-0.5">
                        <span class="w-2 h-2 rounded-full bg-emerald-400 inline-block animate-pulse"></span> 
                        Connected & Search Enabled
                    </p>
                </div>
            </div>
        </div>

        <div id="chat-box" class="flex-1 overflow-y-auto p-6 space-y-6 chat-container scroll-smooth">
            <div class="flex items-start gap-4">
                <div class="w-10 h-10 bg-indigo-600 rounded-full flex items-center justify-center flex-shrink-0 shadow-md">
                    <i class="fa-solid fa-robot text-sm text-white"></i>
                </div>
                <div class="bg-gray-800 border border-gray-700 p-4 rounded-2xl rounded-tl-none max-w-[80%] shadow-md">
                    <p class="text-sm leading-relaxed text-gray-200">Hey! I'm online. I remember everything we talk about and can browse the web to answer real-time questions. Try asking me the current price of Bitcoin or the weather in Mumbai!</p>
                </div>
            </div>
        </div>

        <div class="p-5 bg-gray-950 border-t border-gray-800">
            <form id="chat-form" class="flex gap-3 relative max-w-full">
                <input type="text" id="user-input" 
                    class="w-full bg-gray-900 border border-gray-700 rounded-full py-4 pl-6 pr-16 text-sm focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 transition-all placeholder-gray-500 text-white shadow-inner" 
                    placeholder="Message Gemini..." required autocomplete="off">
                
                <button type="submit" id="send-btn" 
                    class="bg-indigo-600 hover:bg-indigo-500 text-white rounded-full p-3 w-12 h-12 flex items-center justify-center shadow-lg transition-all absolute right-2 top-1.5 group">
                    <i class="fa-solid fa-paper-plane group-hover:scale-110 transition-transform"></i>
                </button>
            </form>
        </div>
    </div>

    <script>
        const chatForm = document.getElementById('chat-form');
        const userInput = document.getElementById('user-input');
        const chatBox = document.getElementById('chat-box');
        const sendBtn = document.getElementById('send-btn');

        function formatMessage(text) {
            return text.replace(/\*\*(.*?)\*\*/g, '<strong class="text-white">$1</strong>').replace(/\n/g, '<br>');
        }

        function addMessage(message, isUser = false) {
            const div = document.createElement('div');
            div.className = `flex items-start gap-4 ${isUser ? 'flex-row-reverse' : ''}`;
            const icon = isUser
                ? `<div class="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center flex-shrink-0 shadow-md"><i class="fa-solid fa-user text-sm text-white"></i></div>`
                : `<div class="w-10 h-10 bg-indigo-600 rounded-full flex items-center justify-center flex-shrink-0 shadow-md"><i class="fa-solid fa-robot text-sm text-white"></i></div>`;
            const bubbleClasses = isUser ? 'bg-blue-600 text-white rounded-tr-none' : 'bg-gray-800 border border-gray-700 text-gray-200 rounded-tl-none';
            div.innerHTML = `${icon}<div class="${bubbleClasses} p-4 rounded-2xl max-w-[80%] shadow-md text-sm leading-relaxed"><p>${formatMessage(message)}</p></div>`;
            chatBox.appendChild(div);
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        function addLoader() {
            const div = document.createElement('div');
            div.id = 'typing-indicator';
            div.className = 'flex items-start gap-4';
            div.innerHTML = `<div class="w-10 h-10 bg-indigo-600 rounded-full flex items-center justify-center flex-shrink-0 shadow-md"><i class="fa-solid fa-robot text-sm text-white"></i></div><div class="bg-gray-800 border border-gray-700 p-4 rounded-2xl rounded-tl-none flex gap-1.5 items-center shadow-md h-12 px-5"><div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div><div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.15s"></div><div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.3s"></div></div>`;
            chatBox.appendChild(div);
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        function removeLoader() {
            const loader = document.getElementById('typing-indicator');
            if (loader) loader.remove();
        }

        chatForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const message = userInput.value.trim();
            if (!message) return;
            addMessage(message, true);
            userInput.value = '';
            userInput.disabled = true; sendBtn.disabled = true; sendBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i>';
            addLoader();
            try {
                const response = await fetch('/api/chat', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ message: message }) });
                const data = await response.json();
                removeLoader();
                if (data.error) addMessage("❌ Server Error: " + data.error);
                else addMessage(data.response);
            } catch (error) {
                removeLoader(); addMessage("❌ Network error. Check if the Flask server is running.");
            } finally {
                userInput.disabled = false; sendBtn.disabled = false; sendBtn.innerHTML = '<i class="fa-solid fa-paper-plane group-hover:scale-110 transition-transform"></i>'; userInput.focus();
            }
        });
    </script>
</body>
</html>
EOF

# 7. Create README.md
cat << 'EOF' > README.md
# QSkill Internship: Gemini AI Assistant

## Overview
This project fulfills the Intermediate Slab requirement for the QSkill Python Development Internship. It integrates the Google Generative AI API (Gemini 1.5 Flash) with a Flask backend and a modern Tailwind CSS frontend. 

## Features
- **Conversation History:** The model natively remembers the context of the chat.
- **Real-Time Data Retrieval:** Integrates the Google Custom Search API via Function Calling. The AI can autonomously browse the web to answer real-time queries (e.g., "What is the weather in Mumbai?").
- **Modern UI:** Responsive, dark-themed interface built with Tailwind CSS.

## Setup Instructions
1. Ensure you have your API keys:
   - `GEMINI_API_KEY` from Google AI Studio.
   - `Google Search_API_KEY` from Google Cloud Console.
   - `SEARCH_ENGINE_ID` (cx) configured to search the entire web.
2. Add these keys to the `.env` file.
3. Activate your virtual environment and run: `python app.py`
4. Visit `http://127.0.0.1:5000` in your browser.
EOF

# 8. Setup Virtual Environment and Install Dependencies
echo "🐍 Setting up Python Virtual Environment..."
python3 -m venv venv
source venv/bin/activate
echo "📦 Installing dependencies..."
pip install -r requirements.txt

echo "================================================"
echo "✅ Project generated successfully!"
echo "================================================"
echo "Next steps:"
echo "1. Run: cd qskill-gemini-bot"
echo "2. Run: source venv/bin/activate"
echo "3. Open the .env file and paste your actual API keys."
echo "4. Run: python app.py"
echo "================================================"
