from django.test import TestCase
from django.contrib.auth.models import User
from .models import Transaction
from django.core.exceptions import ValidationError
from datetime import date

class TransactionModelTest(TestCase):
    def setUp(self):
        # i created a user from this code
        self.user = User.objects.create_user(username='testuser', password='password123')

    def test_create_transaction(self):
        # we will test normal transaction from this
        t = Transaction.objects.create(
            user=self.user,
            amount=100.00,
            transaction_type='INCOME',
            category='Salary',
            date=date.today()
        )
        self.assertEqual(t.amount, 100.00)

    def test_negative_amount_validation(self):
        # it is testing that my custom validators are blocking negative numbers or not
        t = Transaction(
            user=self.user,
            amount=-50.00,
            transaction_type='EXPENSE',
            category='Food',
            date=date.today()
        )
        with self.assertRaises(ValidationError):
            t.full_clean() # now finally this will trigger the validation logic
            