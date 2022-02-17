from datetime import datetime
from django.db import models
from django.contrib.auth.models import User
from pytz import timezone

class Source(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=250, blank=True,null=True)
    is_secure = models.BooleanField(default=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.title
    
class Category(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=250, blank=True,null=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    

    def __str__(self):
        return self.title
    


class Income(models.Model):
    title = models.CharField(max_length=50)
    amount = models.FloatField(default=0)
    desc = models.CharField(max_length=200, blank=True)
    added_at = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    source = models.ManyToManyField(Source, blank=False)

    class Meta:
        ordering = ('-added_at',)

    def __str__(self):
        return self.title


class Expenses(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=250, blank=True)
    amount = models.FloatField(default=0)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    added_at = models.DateTimeField(auto_now_add=True)
    categories = models.ManyToManyField(Category, blank=False)

    class Meta:
        ordering = ('-added_at',)

    def __str__(self):
        return self.title
