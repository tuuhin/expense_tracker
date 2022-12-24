import '../../utils/resource.dart';
import '../models/models.dart';

abstract class GoalsRepository {
  Future<Resource<List<GoalsModel>>> getGoals();
  Future<Resource<GoalsModel?>> addGoal(CreateGoalModel goal);
  Future<Resource<GoalsModel?>> updateGoal(GoalsModel goal);
  Future<Resource<void>> removeGoal(GoalsModel goal);
}
