from django.urls import path
from .views import income_details, sources, categories, income, expenses,source_detail
from .multimodelviews import Entries

urlpatterns = [

    path('sources', sources, name="sources"),
    path('sources/<int:pk>', source_detail, name='source_details'),
    path('income', income, name='income'),
    path('income/<int:pk>',income_details,name="income_details"),
    path('categories', categories, name='categories'),
    path('expenses', expenses, name="expenses"),
    path('entries', Entries.as_view(), name="entries"),

]
