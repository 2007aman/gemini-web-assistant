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
