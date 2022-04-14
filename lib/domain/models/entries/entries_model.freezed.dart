// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'entries_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EntriesModel _$EntriesModelFromJson(Map<String, dynamic> json) {
  return _EntriesModel.fromJson(json);
}

/// @nodoc
class _$EntriesModelTearOff {
  const _$EntriesModelTearOff();

  _EntriesModel call(
      {required int id,
      required String title,
      required String type,
      String? desc,
      bool? isSecure}) {
    return _EntriesModel(
      id: id,
      title: title,
      type: type,
      desc: desc,
      isSecure: isSecure,
    );
  }

  EntriesModel fromJson(Map<String, Object?> json) {
    return EntriesModel.fromJson(json);
  }
}

/// @nodoc
const $EntriesModel = _$EntriesModelTearOff();

/// @nodoc
mixin _$EntriesModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  bool? get isSecure => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntriesModelCopyWith<EntriesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntriesModelCopyWith<$Res> {
  factory $EntriesModelCopyWith(
          EntriesModel value, $Res Function(EntriesModel) then) =
      _$EntriesModelCopyWithImpl<$Res>;
  $Res call({int id, String title, String type, String? desc, bool? isSecure});
}

/// @nodoc
class _$EntriesModelCopyWithImpl<$Res> implements $EntriesModelCopyWith<$Res> {
  _$EntriesModelCopyWithImpl(this._value, this._then);

  final EntriesModel _value;
  // ignore: unused_field
  final $Res Function(EntriesModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? type = freezed,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
abstract class _$EntriesModelCopyWith<$Res>
    implements $EntriesModelCopyWith<$Res> {
  factory _$EntriesModelCopyWith(
          _EntriesModel value, $Res Function(_EntriesModel) then) =
      __$EntriesModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, String title, String type, String? desc, bool? isSecure});
}

/// @nodoc
class __$EntriesModelCopyWithImpl<$Res> extends _$EntriesModelCopyWithImpl<$Res>
    implements _$EntriesModelCopyWith<$Res> {
  __$EntriesModelCopyWithImpl(
      _EntriesModel _value, $Res Function(_EntriesModel) _then)
      : super(_value, (v) => _then(v as _EntriesModel));

  @override
  _EntriesModel get _value => super._value as _EntriesModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? type = freezed,
    Object? desc = freezed,
    Object? isSecure = freezed,
  }) {
    return _then(_EntriesModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
class _$_EntriesModel implements _EntriesModel {
  const _$_EntriesModel(
      {required this.id,
      required this.title,
      required this.type,
      this.desc,
      this.isSecure});

  factory _$_EntriesModel.fromJson(Map<String, dynamic> json) =>
      _$$_EntriesModelFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String type;
  @override
  final String? desc;
  @override
  final bool? isSecure;

  @override
  String toString() {
    return 'EntriesModel(id: $id, title: $title, type: $type, desc: $desc, isSecure: $isSecure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EntriesModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.isSecure, isSecure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(isSecure));

  @JsonKey(ignore: true)
  @override
  _$EntriesModelCopyWith<_EntriesModel> get copyWith =>
      __$EntriesModelCopyWithImpl<_EntriesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EntriesModelToJson(this);
  }
}

abstract class _EntriesModel implements EntriesModel {
  const factory _EntriesModel(
      {required int id,
      required String title,
      required String type,
      String? desc,
      bool? isSecure}) = _$_EntriesModel;

  factory _EntriesModel.fromJson(Map<String, dynamic> json) =
      _$_EntriesModel.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get type;
  @override
  String? get desc;
  @override
  bool? get isSecure;
  @override
  @JsonKey(ignore: true)
  _$EntriesModelCopyWith<_EntriesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
