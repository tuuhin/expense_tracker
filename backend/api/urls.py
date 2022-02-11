from django.urls import path
from .views import  sources,categories,income,expenses
from .multimodelviews import Entries

urlpatterns = [
    path('sources', sources, name="sources"),
    path('income', income, name='income'),
    path('categories', categories, name='categories'),
    path('expenses',expenses,name="expenses"),
    path('entries',Entries.as_view(),name="entries"),
  
]
