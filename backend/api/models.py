from django.db import models
from django.contrib.auth.models import User


class Source(models.Model):
    source_title = models.CharField(max_length=50, unique=True)
    source_desc = models.CharField(max_length=250, blank=True)
    is_secure = models.BooleanField(default=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.source_title


class Category(models.Model):
    category_title = models.CharField(max_length=50, unique=True)
    category_desc = models.CharField(max_length=250, blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.category_title



class Income(models.Model):
    income_title = models.CharField(max_length=50)
    income_amount = models.PositiveIntegerField(default=0)
    income_desc = models.CharField(max_length=200, blank=True)
    added_at = models.DateTimeField(auto_now_add=True)
    categories = models.ManyToManyField(Category)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    source = models.ForeignKey(Source, on_delete=models.CASCADE)

    class Meta:
        ordering = ('-added_at',)

    def __str__(self):
        return self.income_title


class Expenses(models.Model):
    expense_title = models.CharField(max_length=50)
    expense_desc = models.CharField(max_length=250, blank=True)
    expense_amount = models.PositiveIntegerField(default=0)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    added_at = models.DateTimeField(auto_now_add=True)
    categories = models.ManyToManyField(Category, blank=True)

    class Meta:
        ordering = ('-added_at',)

    def __str__(self):
        return self.expense_titlte
