from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from core.views import TransactionViewSet, AnalyticsView
from django.views.generic.base import RedirectView 


router = DefaultRouter()
router.register(r'transactions', TransactionViewSet)

urlpatterns = [
    path('', RedirectView.as_view(url='api/transactions/')),

    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('api/analytics/', AnalyticsView.as_view()),
    # transactions/urls.py mein
path('transactions/api/analytics/', AnalyticsView.as_view(), name='analytics'),
]
