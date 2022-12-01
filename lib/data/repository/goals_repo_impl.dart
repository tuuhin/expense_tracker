import '../../domain/models/models.dart';
import '../../domain/repositories/goals_repository.dart';
import '../dto/dto.dart';
import '../local/goals_dao.dart';
import '../remote/goals_client.dart';

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsClient clt;
  final GoalsDao dao;

  GoalsRepositoryImpl({required this.clt, required this.dao});
  @override
  Future<GoalsModel> addGoal(GoalsModel goal) async {
    GoalsDto add = await clt.addGoal(GoalsDto.fromModel(goal));
    dao.addGoal(add.toEntity());
    return add.toModel();
  }

  @override
  Future<List<GoalsModel>> getGoals() async {
    List<GoalsDto> goals = await clt.getGoals();

    await dao.deleteAll();
    await dao.addGoalsList(goals.map((e) => e.toEntity()).toList());
    return dao.getGoals().map((e) => GoalsDto.fromEntity(e).toModel()).toList();
  }

  @override
  Future<void> removeGoal(GoalsModel goal) async {
    clt.deleteGoal(GoalsDto.fromModel(goal));
    dao.deleteGoal(GoalsDto.fromModel(goal).toEntity());
  }
}
