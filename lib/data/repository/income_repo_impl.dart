import 'package:expense_tracker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../dto/dto.dart';
import '../entity/entity.dart';
import '../local/storage.dart';
import '../remote/remote.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class IncomesRepoImpl implements IncomeRepostiory {
  final IncomeApi api;
  final IncomeStorage incomeStore;
  final IncomeSourceStorage sourceStore;

  IncomesRepoImpl({
    required this.api,
    required this.incomeStore,
    required this.sourceStore,
  });

  @override
  List<IncomeModel> cachedIncomes() => incomeStore
      .getIncomes()
      .map((e) => IncomeDto.fromEntity(e).toModel())
      .toList();

  @override
  List<IncomeSourceModel> cachedSources() => sourceStore
      .getSources()
      .map((e) => IncomeSourceDto.fromEntity(e).toModel())
      .toList();

  @override
  Future<Resource<IncomeModel?>> createIncome(CreateIncomeModel income) async {
    try {
      IncomeDto dto = await api.createIncome(CreateIncomeDto.fromModel(income));
      await incomeStore.addIncome(dto.toEntity());
      IncomeEntity? entity = incomeStore.getEntityById(dto.toEntity());
      if (entity == null) {
        return Resource.data(data: null, message: "Not found");
      }
      return Resource.data(data: IncomeDto.fromEntity(entity).toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<IncomeSourceModel?>> createSource(
      CreateIncomeSourceModel source) async {
    try {
      IncomeSourceDto dto =
          await api.createSource(CreateSourceDto.fromModel(source));
      await sourceStore.addSource(dto.toEntity());
      IncomeSourceEntity? entity = sourceStore.getEntityById(dto.toEntity());
      if (entity == null) {
        throw HiveError("entry not found");
      }
      return Resource.data(data: IncomeSourceDto.fromEntity(entity).toModel());
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<void>> deleteSource(IncomeSourceModel source) async {
    try {
      await api.deleteSource(IncomeSourceDto.fromModel(source));
      await sourceStore
          .deleteSource(IncomeSourceDto.fromModel(source).toEntity());

      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<void>> deleteIncome(IncomeModel income) async {
    try {
      await api.deleteIncome(IncomeDto.fromModel(income));
      await incomeStore.deleteIncome(IncomeDto.fromModel(income).toEntity());

      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<List<IncomeModel>>> getIncomes() async {
    try {
      Iterable<IncomeDto> incomes = await api.getIcomes();
      incomeStore.deleteAll();
      incomeStore.addIncomes(incomes.map((e) => e.toEntity()).toList());
      return Resource.data(
        data: incomeStore
            .getIncomes()
            .map((e) => IncomeDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e) {
      return Resource.error(
        err: e,
        errorMessage: "Unknown error",
        data: incomeStore
            .getIncomes()
            .map((e) => IncomeDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }

  @override
  Future<Resource<List<IncomeSourceModel>>> getSources() async {
    try {
      Iterable<IncomeSourceDto> sources = await api.getSources();
      sourceStore.deleteAll();
      logger.fine("removed all");
      sourceStore.addSources(sources.map((e) => e.toEntity()).toList());
      logger.fine("adding");
      return Resource.data(
        data: sourceStore
            .getSources()
            .map((e) => IncomeSourceDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e) {
      return Resource.error(
        err: e,
        errorMessage: "Unknown error",
        data: sourceStore
            .getSources()
            .map((e) => IncomeSourceDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }
}
