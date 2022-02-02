from rest_framework.decorators import api_view,permission_classes
from rest_framework.permissions import IsAuthenticated
from .serializers import UserSerializer
from rest_framework.response import Response
from rest_framework import status


@api_view(http_method_names=['POST'])
def register_users(request):

    user = UserSerializer(data=request.data)
    if user.is_valid():
        user.save()
        tokens = user.get_tokens(user.data.get("id"))
        return Response({'user':user.data,'tokens':tokens},status=status.HTTP_201_CREATED)
    else:
        return Response(user.errors,status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def check_auth(request):
    print(request.headers)
    return Response({'status':'authenticated'})