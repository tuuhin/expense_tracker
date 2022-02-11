from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .serializers import (CategorySerializer, ExpenseSerializer,
                          IncomeSerializer, SourceSerializer)
from .models import Expenses, Income, Category, Source
# Create your views here.

@api_view(http_method_names=['GET', 'POST'])
@permission_classes([IsAuthenticated])
def sources(request):
    if request.method == 'GET':
        sources = Source.objects.filter(user=request.user)
        source_serializer = SourceSerializer(sources, many=True)
        return Response(source_serializer.data, status=status.HTTP_200_OK)

    if request.method == 'POST':
        data = request.data
        data['user'] = request.user.pk
        income_serializer = SourceSerializer(data=data)
        if income_serializer.is_valid():
            income_serializer.save()
            return Response(income_serializer.data, status=status.HTTP_201_CREATED)
        return Response(income_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(http_method_names=['GET', 'POST'])
def categories(request):
    if request.method == 'GET':
        categories = Category.objects.filter(user=request.user)
        serialized_categories = CategorySerializer(categories, many=True)
        return Response(serialized_categories.data, status=status.HTTP_200_OK)
    if request.method == 'POST':
        data = request.data
        data['user'] = request.user.pk
        serialized_category = CategorySerializer(data=data)
        if serialized_category.is_valid():
            return Response(serialized_category.data, status=status.HTTP_201_CREATED)
        return Response(serialized_category.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(http_method_names=['GET', 'POST'])
@permission_classes([IsAuthenticated])
def income(request):
    if request.method == 'GET':
        incomes = Income.objects.filter(user=request.user)
        serialized_incomes = IncomeSerializer(incomes, many=True)
        return Response(serialized_incomes.data, status=status.HTTP_200_OK)
    if request.method == 'POST':
        data = request.data
        data['user'] = request.user.pk
        serialized_income = IncomeSerializer(data=data)
        if serialized_income.is_valid():
            return Response(serialized_income.data, status=status.HTTP_201_CREATED)
        return Response(serialized_income.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(http_method_names=['POST', 'GET'])
@permission_classes([IsAuthenticated])
def expenses(request):
    if request.method == 'GET':
        expenses = Expenses.objects.filter(user=request.user)
        expense_serializer = ExpenseSerializer(data=expenses, many=True)
        return Response(expense_serializer.data, status=status.HTTP_200_OK)
    if request.method == 'POST':
        data = request.data
        data['user'] = request.user
        serialized_expense = ExpenseSerializer(data)
        if serialized_expense.is_valid():
            serialized_expense.save()
            return Response(serialized_expense.data, status=status.HTTP_201_CREATED)
        return Response(serialized_expense.data, status=status.HTTP_400_BAD_REQUEST)
