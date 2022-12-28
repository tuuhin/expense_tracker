import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';
import '../dto/dto.dart';
import '../entity/entity.dart';
import '../remote/remote.dart';
import '../local/goals_dao.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsClient clt;
  final GoalsDao dao;

  GoalsRepositoryImpl({required this.clt, required this.dao});

  @override
  Future<Resource<GoalsModel?>> addGoal(CreateGoalModel goal) async {
    try {
      GoalsDto dto = await clt.addGoal(CreateGoalDto.fromModel(goal));

      await dao.addGoal(dto.toEntity());

      GoalsEntity? entity = await dao.getGoalById(dto.toEntity());
      if (entity == null) {
        return Resource.data(data: null);
      }
      return Resource.data(
          data: GoalsDto.fromEntity(entity).toModel(), message: "Goal added");
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: dio.type == DioErrorType.response
            ? ErrorDetialsDto.fromJson(
                        (dio.response?.data as Map<String, dynamic>))
                    .details ??
                "Something related to dio occered "
            : "Some dio error happened",
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Unknown Error Occured");
    }
  }

  @override
  Future<Resource<List<GoalsModel>>> getGoals() async {
    try {
      List<GoalsDto> goals = await clt.getGoals();
      await dao.deleteAll();
      await dao.addGoals(goals.map((e) => e.toEntity()).toList());
      return Resource.data(
          data: (await dao.getGoals())
              .map((e) => GoalsDto.fromEntity(e).toModel())
              .toList(),
          message: "Successfully fetched data");
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: dio.type == DioErrorType.response
            ? ErrorDetialsDto.fromJson(
                        (dio.response?.data as Map<String, dynamic>))
                    .details ??
                "Something related to dio occered "
            : "Some dio error happened",
        data: (await dao.getGoals())
            .map((e) => GoalsDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(
        err: e,
        errorMessage: "Unknown Error Occured",
        data: (await dao.getGoals())
            .map((e) => GoalsDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }

  @override
  Future<Resource<void>> removeGoal(GoalsModel goal) async {
    try {
      await clt.deleteGoal(GoalsDto.fromModel(goal));
      await dao.deleteGoal(GoalsDto.fromModel(goal).toEntity());
      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "error occured");
    }
  }

  @override
  Future<Resource<GoalsModel?>> updateGoal(GoalsModel goal) async {
    try {
      GoalsDto dto = await clt.updateGoal(GoalsDto.fromModel(goal));

      await dao.updateGoal(dto.toEntity());

      GoalsEntity? entity = await dao.getGoalById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);

      return Resource.data(
          data: GoalsDto.fromEntity(entity).toModel(), message: "Goal added");
    } on DioError catch (dio) {
      logger.fine(dio.response?.data);
      return Resource.error(
        err: dio,
        errorMessage: dio.type == DioErrorType.response
            ? ErrorDetialsDto.fromJson(
                        (dio.response?.data as Map<String, dynamic>))
                    .details ??
                "Something related to dio occered "
            : "Some dio error happened",
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Unknown Error Occured");
    }
  }
}
