import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
class Resource<T> with _$Resource<T> {
  factory Resource.loading() = Loading;
  factory Resource.data({required T data, String? message}) = Data;
  factory Resource.error({
    required Object err,
    String? errorMessage,
    T? data,
  }) = ErrorDetails;
}
