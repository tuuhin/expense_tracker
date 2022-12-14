import 'package:dio/dio.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/cupertino.dart';

import '../dto/dto.dart';
import '../local/storage.dart';
import '../remote/auth_api.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class AuthRespositoryImpl implements AuthRespository {
  final SecureStorage storage;
  final AuthApi auth;
  final UserProfileRepository profileData;

  AuthRespositoryImpl({
    required this.storage,
    required this.auth,
    required this.profileData,
  });

  @override
  Future<Resource> createUser(CreateUserModel user) async {
    try {
      AuthResultsDto dto = await auth.createUser(CreateUserDto.fromModel(user));

      await profileData.setProfile(dto.profile.toModel());
      await storage.setTokens(
          access: dto.token.access, refresh: dto.token.refresh);
      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource> logUserIn(LoginUserModel user) async {
    try {
      AuthResultsDto dto = await auth.loginUser(LoginUserDto.fromModel(user));

      await profileData.setProfile(dto.profile.toModel());
      await storage.setTokens(
          access: dto.token.access, refresh: dto.token.refresh);
      return Resource.data(data: null);
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "unknown error");
    }
  }

  @override
  Future<Resource> checkAuthState() async {
    try {
      String? token = await storage.getAccessToken();
      TokensDto dto = await auth.checkAuthState(token: token ?? "");
      await storage.setTokens(access: dto.access, refresh: dto.refresh);
      logger.fine("setting new tokens");
      return Resource.data(data: null);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return Resource.error(err: e, errorMessage: "Unauthorized");
      }
      return Resource.data(data: null);
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.data(data: null);
    }
  }

  @override
  Future<void> logOut() async {
    await storage.removeTokens();
  }
}
