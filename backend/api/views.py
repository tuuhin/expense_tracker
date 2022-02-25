from datetime import datetime
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
        source_serializer = SourceSerializer(data=data)
        if source_serializer.is_valid():
            source_serializer.save()
            return Response(source_serializer.data, status=status.HTTP_201_CREATED)
        return Response(source_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(http_method_names=['PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
def source_detail(request, pk):
    user = request.user.pk

    if request.method == 'PUT':
        data = request.data
        data['user'] = user
        source_exists = Source.objects.get(pk=pk)
        if source_exists:
            source_serializer = SourceSerializer(source_exists, data=data)
            if source_serializer.is_valid():
                source_serializer.save()
                return Response(source_serializer.data, status=status.HTTP_205_RESET_CONTENT)
            return Response(source_serializer.errors, status=status.HTTP_424_FAILED_DEPENDENCY)
        else:
            return Response({'data': 'source don\'t exists'}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'DELETE':
        source_exists = Source.objects.filter(user=user, pk=pk)
        if source_exists:
            source_exists.delete()
            return Response({'data': 'the source has been deleted '}, status=status.HTTP_204_NO_CONTENT)
        return Response({'data': 'source dont\'t exists'}, status=status.HTTP_404_NOT_FOUND)


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
            serialized_income.save()
            return Response(serialized_income.data, status=status.HTTP_201_CREATED)
        return Response(serialized_income.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(http_method_names=['DELETE'])
@permission_classes([IsAuthenticated])
def income_details(request, pk):
    user = request.user.pk
    income_existis = Income.objects.filter(user=user, pk=pk)
    if income_existis:
        income_existis.delete()
        return Response({'data': 'removed'}, status=status.HTTP_204_NO_CONTENT)
    return Response({'data': 'error could not edit the source'}, status=status.HTTP_404_NOT_FOUND)


@api_view(http_method_names=['GET', 'POST'])
@permission_classes([IsAuthenticated])
def expenses(request):

    if request.method == 'GET':
        expenses = Expenses.objects.filter(user=request.user)
        expense_serializer = ExpenseSerializer(expenses, many=True)
        return Response(expense_serializer.data, status=status.HTTP_200_OK)

    if request.method == 'POST':
        data = request.data
        data['user'] = request.user.pk
        serialized_expense = ExpenseSerializer(data=data)
        if serialized_expense.is_valid():
            serialized_expense.save()
            return Response(serialized_expense.data, status=status.HTTP_201_CREATED)
        return Response(serialized_expense.data, status=status.HTTP_400_BAD_REQUEST)


@api_view(http_method_names=['GET'])
@permission_classes([IsAuthenticated])
def base_information(request):
    user = request.user
    current_month = datetime.now().month
    total_income, total_expense = 0, 0
    monthly_income, monthly_expense = 0, 0

    for income in Income.objects.filter(user=user):
        total_income += income.amount
        if income.added_at.month == current_month:
            monthly_income += income.amount

    for expense in Expenses.objects.filter(user=user):
        total_expense += expense.amount
        if expense.added_at.month == current_month:
            monthly_expense += expense.amount

    return Response({
        'total_income': total_income,
        'montly_income': monthly_income,
        'total_expense': total_expense,
        'monthly_expense': monthly_expense
    }, status=status.HTTP_200_OK)
