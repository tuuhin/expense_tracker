import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'entries_state.dart';

class EntriesCubit extends Cubit<EntriesState> {
  EntriesCubit() : super(EntriesLoad());
}
