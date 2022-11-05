part of 'entries_cubit.dart';

@immutable
abstract class EntriesState {}

class EntriesLoad extends EntriesState {}

class EntriesLoadSuccess extends EntriesState {
  final List<EntriesModel> data;
  final String? message;
  EntriesLoadSuccess({
    required this.data,
    this.message,
  });
}

class EntriesLoadFailed extends EntriesState {
  final String errMessage;

  EntriesLoadFailed({
    required this.errMessage,
  });
}

class EntriesLoadMore extends EntriesLoadSuccess {
  EntriesLoadMore({
    required List<EntriesModel> data,
    String? message,
  }) : super(data: data, message: message);
}

class EntriesLoadMoreFailed extends EntriesLoadSuccess {
  EntriesLoadMoreFailed({
    required List<EntriesModel> data,
    required String errMessage,
  }) : super(data: data, message: errMessage);
}

class EntriesLoadedAll extends EntriesLoadSuccess {
  EntriesLoadedAll({
    required List<EntriesModel> data,
    required String message,
  }) : super(data: data, message: message);
}
