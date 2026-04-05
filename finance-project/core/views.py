from rest_framework import viewsets, views, permissions
from rest_framework.response import Response
from django.db.models import Sum
from .models import Transaction
from .serializers import TransactionSerializer
from rest_framework.permissions import AllowAny


class RolePermission(permissions.BasePermission):
    def has_permission(self, request, view):
        if not request.user.is_authenticated: return False
        if request.user.is_superuser: return True
        if request.method in permissions.SAFE_METHODS:
            return True
        return False

class TransactionViewSet(viewsets.ModelViewSet):
    queryset = Transaction.objects.all()
    serializer_class = TransactionSerializer
    permission_classes = [AllowAny]
    filterset_fields = ['transaction_type', 'category', 'date']

class AnalyticsView(views.APIView):
    permission_classes = [AllowAny]
    def get(self, request):
        data = Transaction.objects.all()
        income = data.filter(transaction_type='INCOME').aggregate(Sum('amount'))['amount__sum'] or 0
        expense = data.filter(transaction_type='EXPENSE').aggregate(Sum('amount'))['amount__sum'] or 0
        
        return Response({
            "total_income": float(income),
            "total_expenses": float(expense),
            "net_balance": float(income - expense),
            "by_category": list(data.values('category').annotate(total=Sum('amount')))
        })
