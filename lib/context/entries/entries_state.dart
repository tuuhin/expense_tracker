part of 'entries_cubit.dart';

@immutable
abstract class EntriesState {}

class EntriesLoad extends EntriesState {}

class EntriesLoadSuccess extends EntriesState {
  final List<EntriesModel> data;
  final String? message;
  EntriesLoadSuccess({required this.data, this.message});
}

class EntriesLoadFailed extends EntriesState {
  final String? message;
  EntriesLoadFailed({required this.message});
}
