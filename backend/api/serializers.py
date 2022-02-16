from rest_framework.serializers import ModelSerializer,Serializer,CharField,PrimaryKeyRelatedField
from .models import Expenses,Source, Category, Income
from django.contrib.auth.models import User

# Income part 

class SourceSerializer(ModelSerializer):

    class Meta:
        model = Source
        fields = '__all__'
        extra_kwargs = {
            'user': {'write_only': True}
        }


class CategorySerializer(ModelSerializer):

    class Meta:
        model = Category
        fields = '__all__'
        extra_kwargs = {
            'user': {'write_only': True}
        }

class UpdateCategorySerializer(Serializer):
    source = CharField(max_length=50)
    user = PrimaryKeyRelatedField(queryset = User.objects.all())


class IncomeSerializer(ModelSerializer):
    categories = CategorySerializer(many=True, read_only=True)

    class Meta:
        model = Income
        fields = '__all__'
        extra_kwargs = {
            'user': {'write_only': True}
        }


class ExpenseSerializer(ModelSerializer):
    class Meta:
        model = Expenses
        fields = '__all__'
        extra_kwargs = {
            'user':{'write_only':True}
        }