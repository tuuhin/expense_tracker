import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
class Resource<T> with _$Resource<T> {
  factory Resource.loading() = _Loading;
  factory Resource.data({required T data, String? message}) = _Data;
  factory Resource.error({
    required Object err,
    required String errorMessage,
    T? data,
  }) = _ErrorDetails;
}
