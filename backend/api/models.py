from django.db import models
from django.contrib.auth.models import User


class IncomeSource(models.Model):
    source_title = models.CharField(max_length=50)
    source_desc = models.CharField(max_length=250, blank=True)
    is_secure = models.BooleanField(default=True)

    def __str__(self):
        return self.source_title


class IncomeCategory(models.Model):
    category_title = models.CharField(max_length=50)
    category_desc = models.CharField(max_length=250, blank=True)

    def __str__(self):
        return self.category_title


class ExpenseCategory(models.Model):
    category_title = models.CharField(max_length=50)
    category_desc = models.CharField(max_length=250, blank=True)

    def __str__(self):
        return self.category_title


class Income(models.Model):
    income_titlte = models.CharField(max_length=50)
    income_amount = models.PositiveIntegerField(default=0)
    income_desc = models.CharField(max_length=200, blank=True)
    income_added_at = models.DateTimeField(auto_now_add=True)
    categories = models.ManyToManyField(IncomeCategory)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    source = models.OneToOneField(IncomeSource, on_delete=models.CASCADE)

    class Meta:
        ordering = ('-income_added_at',)

    def __str__(self):
        return self.income_titlte


class Expenses(models.Model):
    expense_title = models.CharField(max_length=50)
    expense_desc = models.CharField(max_length=250, blank=True)
    expense_amount = models.PositiveIntegerField(default=0)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    expense_added_at = models.DateTimeField(auto_now_add=True)
    categories = models.ManyToManyField(ExpenseCategory)

    class Meta:
        ordering = ('-expense_added_at',)

    def __str__(self):
        return self.expense_titlte
