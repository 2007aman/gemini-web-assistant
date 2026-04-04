from django.db import models
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError

def validate_positive(value):
    if value <= 0:
        raise ValidationError("Amount must be greater than zero.")

class Transaction(models.Model):
    TYPES = [('INCOME', 'Income'), ('EXPENSE', 'Expense')]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=12, decimal_places=2, validators=[validate_positive])
    transaction_type = models.CharField(max_length=10, choices=TYPES)
    category = models.CharField(max_length=100)
    date = models.DateField()
    description = models.TextField(blank=True)

    def __str__(self):
        return f"{self.transaction_type}: {self.amount}"
