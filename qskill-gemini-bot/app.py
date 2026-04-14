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
# Use the exact string from your terminal list
available_models = [m.name for m in genai.list_models()]
target_model = 'models/gemini-1.5-flash'

# Safety check: if for some reason it's not in the list, fallback to standard pro
if target_model not in available_models:
    print(f"⚠️ {target_model} not found, falling back to gemini-pro")
    target_model = 'models/gemini-3-flash-preview'

model = genai.GenerativeModel(
    model_name=target_model,
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
