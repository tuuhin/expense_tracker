import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'themecubit_state.dart';

class ThemecubitCubit extends Cubit<ThemecubitState> {
  ThemecubitCubit() : super(ThemecubitInitial());
}
