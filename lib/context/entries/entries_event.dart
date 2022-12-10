part of 'entries_bloc.dart';

@freezed
class EntriesEvent with _$EntriesEvent {
  const factory EntriesEvent.fetchSome() = _FetchSome;

  const factory EntriesEvent.fetchMore() = _FetchMore;

  const factory EntriesEvent.refresh() = _Referesh;

  const factory EntriesEvent.clear() = _Clear;
}
