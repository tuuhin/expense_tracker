from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView, TokenObtainPairView
from .views import check_state, register_users, change_password


urlpatterns = [

    path('create', register_users, name="register_user"),
    path('token', TokenObtainPairView.as_view(), name='get_token'),
    path('refresh', TokenRefreshView.as_view(), name='refresh_token'),
    path('change_password', change_password, name="change_password"),
    path('check',check_state,name='check_state')

]
