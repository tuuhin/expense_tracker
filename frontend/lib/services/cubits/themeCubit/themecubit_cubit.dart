import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'themecubit_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight());
}
