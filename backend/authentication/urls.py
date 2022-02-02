from django.urls import path
from rest_framework_simplejwt.views import TokenVerifyView,TokenRefreshView,TokenObtainPairView
from .views import check_auth, register_users
urlpatterns = [
    path('register_user/',register_users,name="register_user"),
    path('get_token/',TokenObtainPairView.as_view(),name='get_token'),
    path('refresh_token/',TokenRefreshView.as_view(),name='refresh_token'),
    path('check/',check_auth)
]