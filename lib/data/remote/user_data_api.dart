import 'package:dio/dio.dart';

import '../dto/dto.dart';
import 'clients/auth_client.dart';

class UserDataApi extends AuthClient {
  Future<UserProfileDto> getUserProfile() async {
    Response response = await dio.get('/profile');
    return UserProfileDto.fromJson(response.data);
  }

  Future<UserProfileDto> updateProfile(UserProfileDto dto) async {
    Response response = await dio.put(
      '/update-profile',
      data: FormData.fromMap(
        {
          ...dto.toJson(),
          'photoURL': dto.photoURL != null
              ? await MultipartFile.fromFile(dto.photoURL!,
                  filename: dto.photoURL)
              : null
        },
      ),
    );
    return UserProfileDto.fromJson(response.data);
  }

  Future<void> changePassword(ChangePasswordDto dto) async =>
      await dio.post('/change-password', data: dto.toJson());
}
