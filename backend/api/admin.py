from django.contrib import admin
from .models import Income,  Source, Category, Expenses

# Register your models here.
admin.site.register(Income)
admin.site.register(Source)
admin.site.register(Category)
admin.site.register(Expenses)
