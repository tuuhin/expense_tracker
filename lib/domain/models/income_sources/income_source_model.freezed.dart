// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'income_source_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IncomeSourceModel _$IncomeSourceModelFromJson(Map<String, dynamic> json) {
  return _IncomeSourceModel.fromJson(json);
}

/// @nodoc
class _$IncomeSourceModelTearOff {
  const _$IncomeSourceModelTearOff();

  _IncomeSourceModel call(
      {required int id, required String title, String? desc, bool? isSecure}) {
    return _IncomeSourceModel(
      id: id,
      title: title,
      desc: desc,
      isSecure: isSecure,
    );
  }

  IncomeSourceModel fromJson(Map<String, Object?> json) {
    return IncomeSourceModel.fromJson(json);
  }
}

/// @nodoc
const $IncomeSourceModel = _$IncomeSourceModelTearOff();

/// @nodoc
mixin _$IncomeSourceModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  bool? get isSecure => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncomeSourceModelCopyWith<IncomeSourceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeSourceModelCopyWith<$Res> {
  factory $IncomeSourceModelCopyWith(
          IncomeSourceModel value, $Res Function(IncomeSourceModel) then) =
      _$IncomeSourceModelCopyWithImpl<$Res>;
  $Res call({int id, String title, String? desc, bool? isSecure});
}

/// @nodoc
class _$IncomeSourceModelCopyWithImpl<$Res>
    implements $IncomeSourceModelCopyWith<$Res> {
  _$IncomeSourceModelCopyWithImpl(this._value, this._then);

  final IncomeSourceModel _value;
  // ignore: unused_field
  final $Res Function(IncomeSourceModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? isSecure = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      isSecure: isSecure == freezed
          ? _value.isSecure
          : isSecure // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$IncomeSourceModelCopyWith<$Res>
    implements $IncomeSourceModelCopyWith<$Res> {
  factory _$IncomeSourceModelCopyWith(
          _IncomeSourceModel value, $Res Function(_IncomeSourceModel) then) =
      __$IncomeSourceModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, String title, String? desc, bool? isSecure});
}

/// @nodoc
class __$IncomeSourceModelCopyWithImpl<$Res>
    extends _$IncomeSourceModelCopyWithImpl<$Res>
    implements _$IncomeSourceModelCopyWith<$Res> {
  __$IncomeSourceModelCopyWithImpl(
      _IncomeSourceModel _value, $Res Function(_IncomeSourceModel) _then)
      : super(_value, (v) => _then(v as _IncomeSourceModel));

  @override
  _IncomeSourceModel get _value => super._value as _IncomeSourceModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? desc = freezed,
    Object? isSecure = freezed,
  }) {
    return _then(_IncomeSourceModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      isSecure: isSecure == freezed
          ? _value.isSecure
          : isSecure // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IncomeSourceModel implements _IncomeSourceModel {
  const _$_IncomeSourceModel(
      {required this.id, required this.title, this.desc, this.isSecure});

  factory _$_IncomeSourceModel.fromJson(Map<String, dynamic> json) =>
      _$$_IncomeSourceModelFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? desc;
  @override
  final bool? isSecure;

  @override
  String toString() {
    return 'IncomeSourceModel(id: $id, title: $title, desc: $desc, isSecure: $isSecure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IncomeSourceModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.isSecure, isSecure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(isSecure));

  @JsonKey(ignore: true)
  @override
  _$IncomeSourceModelCopyWith<_IncomeSourceModel> get copyWith =>
      __$IncomeSourceModelCopyWithImpl<_IncomeSourceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IncomeSourceModelToJson(this);
  }
}

abstract class _IncomeSourceModel implements IncomeSourceModel {
  const factory _IncomeSourceModel(
      {required int id,
      required String title,
      String? desc,
      bool? isSecure}) = _$_IncomeSourceModel;

  factory _IncomeSourceModel.fromJson(Map<String, dynamic> json) =
      _$_IncomeSourceModel.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get desc;
  @override
  bool? get isSecure;
  @override
  @JsonKey(ignore: true)
  _$IncomeSourceModelCopyWith<_IncomeSourceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
