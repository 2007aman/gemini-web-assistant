from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Transaction

@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    #  makes the list view show more than just one column
    list_display = ('date', 'user', 'transaction_type', 'category', 'amount')
    
    #  adds a sidebar on the right to filter data easily
    list_filter = ('transaction_type', 'category', 'date')
    
    # adds a search bar at the top
    search_fields = ('category', 'description', 'user__username')
    
    #  makes the list sorted by date (newest first) by default
    ordering = ('-date',)