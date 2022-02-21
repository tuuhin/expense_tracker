from rest_framework.serializers import ModelSerializer, CharField, Serializer
from django.contrib.auth.models import User
from rest_framework_simplejwt.tokens import RefreshToken


def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)
    return {
        'refresh': str(refresh),
        'access': str(refresh.access_token),
    }


class UserSerializer(ModelSerializer):
    
    class Meta:
        model = User
        fields = ('id', 'username', 'password',
                  'email', 'first_name', 'last_name')
        extra_kwargs = {
            'email': {'required': True},
            'password': {'write_only': True}
        }

    def get_tokens(self, pk):
        current_user = User.objects.get(pk=pk)
        tokens = get_tokens_for_user(current_user)
        return tokens


class ChangePasswordSerializer(Serializer):
    old_password = CharField(required=True)
    new_password = CharField(required=True)
