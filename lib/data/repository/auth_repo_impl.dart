import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/models/auth/tokens.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../dto/dto.dart';
import '../local/storage.dart';
import '../remote/user_profile.dart';

class AuthenticationRespositoryImpl implements AuthenticationRespository {
  static final String _endPoint = dotenv.get('AUTH_ENDPOINT');
  final SecureStorage _storage = SecureStorage();

  final UserProfileRepository _profileData = UserProfileRepositoryImpl();

  final Dio _dio = Dio()
    ..options = BaseOptions(
      headers: {'Content-type': 'application/json'},
      baseUrl: _endPoint,
    );

  @override
  Future<void> createUser({
    required String username,
    required String password,
    required String email,
  }) async {
    Response response = await _dio.post('/create', data: {
      'username': username,
      'password': password,
      'email': email,
    });

    UserAuthBaseResponseDto responseData =
        UserAuthBaseResponseDto.fromJson(response.data);

    Token tokens = responseData.tokens.toToken();
    UserProfileModel userProfile = responseData.profile.toModel();
    // storing the tokens in user-profile box
    await _profileData.setProfile(userProfile);
    // Storing the tokens in secure storage
    await _storage.setAccessToken(tokens.access);
    await _storage.setRefreshToken(tokens.refresh);
  }

  @override
  Future<void> logUserIn({
    required String username,
    required String password,
  }) async {
    Response response = await _dio
        .post('/token', data: {'username': username, 'password': password});
    UserAuthBaseResponseDto responseData =
        UserAuthBaseResponseDto.fromJson(response.data);

    Token tokens = responseData.tokens.toToken();
    UserProfileModel userProfile = responseData.profile.toModel();
    // storing the tokens in user-profile box
    await _profileData.setProfile(userProfile);
    // Storing the tokens in secure storage
    await _storage.setAccessToken(tokens.access);
    await _storage.setRefreshToken(tokens.refresh);
  }

  @override
  Future<bool> checkAuthState() async {
    String? token = await _storage.getAccessToken();
    if (token == null) return false;
    return true;
  }

  @override
  Future<void> logOut() async {
    await _storage.removeTokens();
    // await Hive.close();
  }
}
