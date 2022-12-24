import 'package:dio/dio.dart';

import '../dto/dto.dart';
import './remote.dart';

class GoalsClient extends PlansClient {
  Future<List<GoalsDto>> getGoals() async {
    Response resp = await dio.get('/goals');
    return (resp.data as List).map((e) => GoalsDto.fromJson(e)).toList();
  }

  Future<GoalsDto> addGoal(CreateGoalDto goal) async {
    Response resp = await dio.post(
      '/create-goal',
      data: FormData.fromMap(
        {
          ...goal.toJson(),
          'image': goal.imageUrl != null
              ? await MultipartFile.fromFile(goal.imageUrl!)
              : null,
        },
      ),
    );
    return GoalsDto.fromJson(resp.data);
  }

  Future<GoalsDto> updateGoal(GoalsDto goal) async {
    Response resp = await dio.post(
      '/goals/${goal.id}',
      data: FormData.fromMap(
        {
          ...goal.toJson(),
          'image': goal.imageUrl != null
              ? await MultipartFile.fromFile(goal.imageUrl!)
              : null,
        },
      ),
    );
    return GoalsDto.fromJson(resp.data);
  }

  Future<void> deleteGoal(GoalsDto goal) async =>
      await dio.delete('/goals/${goal.id}');
}
