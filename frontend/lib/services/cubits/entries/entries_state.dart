part of 'entries_cubit.dart';

@immutable
abstract class EntriesState {}

class EntriesLoad extends EntriesState {}

class EntriesLoadSuccess extends EntriesState {
  final List<EntriesModel> entries;
  final int? highestCount;
  final int? overallCount;
  final String? previousURL;
  final String? nextURL;
  EntriesLoadSuccess({
    required this.entries,
    this.highestCount,
    this.overallCount,
    this.previousURL,
    this.nextURL,
  });
}

class EntriesLoadFailed extends EntriesState {}
