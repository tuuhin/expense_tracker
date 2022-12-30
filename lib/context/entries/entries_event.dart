part of 'entries_bloc.dart';

@freezed
class EntriesEvent with _$EntriesEvent {
  factory EntriesEvent.fetchSome() = _FetchSome;

  factory EntriesEvent.fetchMore() = _FetchMore;

  factory EntriesEvent.refresh() = _Referesh;

  factory EntriesEvent.clear() = _Clear;
}
