from django.contrib import admin
from .models import Income, IncomeCategory, IncomeSource, ExpenseCategory, Expenses

# Register your models here.
admin.site.register(Income)
admin.site.register(IncomeCategory)
admin.site.register(IncomeSource)
admin.site.register(ExpenseCategory)
admin.site.register(Expenses)
