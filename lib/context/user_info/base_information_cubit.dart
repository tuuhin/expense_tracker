import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'base_information_state.dart';

class BaseInformationCubit extends Cubit<BaseInformationState> {
  BaseInformationCubit() : super(BaseInformationLoading());
}
