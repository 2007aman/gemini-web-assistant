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
