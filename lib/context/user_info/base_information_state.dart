part of 'base_information_cubit.dart';

@immutable
abstract class BaseInformationState<T> {}

class BaseInformationLoading<T> extends BaseInformationState<T> {}

class BaseInformationLoadSucess<T> extends BaseInformationState<T> {
  final T data;
  BaseInformationLoadSucess(this.data);
}

class BaseInforamtionLoadFailed<T> extends BaseInformationState<T> {
  final T data;
  final String? message;
  BaseInforamtionLoadFailed(this.data, this.message);
}
