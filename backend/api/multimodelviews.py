from drf_multiple_model.views import FlatMultipleModelAPIView
from drf_multiple_model.pagination import MultipleModelLimitOffsetPagination
from rest_framework.permissions import IsAuthenticated
from .serializers import ExpenseSerializer, IncomeSerializer
from .models import Expenses, Income


class Pagination(MultipleModelLimitOffsetPagination):
    default_limit = 10


class Entries(FlatMultipleModelAPIView):

    sorting_field = '-added_at'
    pagination_class = Pagination
    permission_classes = [IsAuthenticated]

    def get_querylist(self):
        querylist = [
            {
                'queryset': Income.objects.filter(user=self.request.user.pk),
                'serializer_class': IncomeSerializer,
                'label': 'income',
            },
            {
                'queryset': Expenses.objects.filter(user=self.request.user.pk),
                'serializer_class': ExpenseSerializer,
                'label': 'expense'
            }, ]

        return querylist
