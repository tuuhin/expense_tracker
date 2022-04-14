// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense_categories_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpenseCategoriesModel _$ExpenseCategoriesModelFromJson(
    Map<String, dynamic> json) {
  return _ExpenseCategoriesModel.fromJson(json);
}

/// @nodoc
class _$ExpenseCategoriesModelTearOff {
  const _$ExpenseCategoriesModelTearOff();

  _ExpenseCategoriesModel call(
      {required int id, required String title, String? desc}) {
    return _ExpenseCategoriesModel(
      id: id,
      title: title,
      desc: desc,
    );
  }

  ExpenseCategoriesModel fromJson(Map<String, Object?> json) {
    return ExpenseCategoriesModel.fromJson(json);
  }
}

/// @nodoc
const $ExpenseCategoriesModel = _$ExpenseCategoriesModelTearOff();

/// @nodoc
mixin _$ExpenseCategoriesModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCategoriesModelCopyWith<ExpenseCategoriesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCategoriesModelCopyWith<$Res> {
  factory $ExpenseCategoriesModelCopyWith(ExpenseCategoriesModel value,
          $Res Function(ExpenseCategoriesModel) then) =
      _$ExpenseCategoriesModelCopyWithImpl<$Res>;
  $Res call({int id, String title, String? desc});
}

/// @nodoc
class _$ExpenseCategoriesModelCopyWithImpl<$Res>
    implements $ExpenseCategoriesModelCopyWith<$Res> {
  _$ExpenseCategoriesModelCopyWithImpl(this._value, this._then);

  final ExpenseCategoriesModel _value;
  // ignore: unused_field
  final $Res Function(ExpenseCategoriesModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? desc = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$ExpenseCategoriesModelCopyWith<$Res>
    implements $ExpenseCategoriesModelCopyWith<$Res> {
  factory _$ExpenseCategoriesModelCopyWith(_ExpenseCategoriesModel value,
          $Res Function(_ExpenseCategoriesModel) then) =
      __$ExpenseCategoriesModelCopyWithImpl<$Res>;
  @override
  $Res call({int id, String title, String? desc});
}

/// @nodoc
class __$ExpenseCategoriesModelCopyWithImpl<$Res>
    extends _$ExpenseCategoriesModelCopyWithImpl<$Res>
    implements _$ExpenseCategoriesModelCopyWith<$Res> {
  __$ExpenseCategoriesModelCopyWithImpl(_ExpenseCategoriesModel _value,
      $Res Function(_ExpenseCategoriesModel) _then)
      : super(_value, (v) => _then(v as _ExpenseCategoriesModel));

  @override
  _ExpenseCategoriesModel get _value => super._value as _ExpenseCategoriesModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? desc = freezed,
  }) {
    return _then(_ExpenseCategoriesModel(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpenseCategoriesModel implements _ExpenseCategoriesModel {
  const _$_ExpenseCategoriesModel(
      {required this.id, required this.title, this.desc});

  factory _$_ExpenseCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseCategoriesModelFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? desc;

  @override
  String toString() {
    return 'ExpenseCategoriesModel(id: $id, title: $title, desc: $desc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpenseCategoriesModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.desc, desc));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(desc));

  @JsonKey(ignore: true)
  @override
  _$ExpenseCategoriesModelCopyWith<_ExpenseCategoriesModel> get copyWith =>
      __$ExpenseCategoriesModelCopyWithImpl<_ExpenseCategoriesModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseCategoriesModelToJson(this);
  }
}

abstract class _ExpenseCategoriesModel implements ExpenseCategoriesModel {
  const factory _ExpenseCategoriesModel(
      {required int id,
      required String title,
      String? desc}) = _$_ExpenseCategoriesModel;

  factory _ExpenseCategoriesModel.fromJson(Map<String, dynamic> json) =
      _$_ExpenseCategoriesModel.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get desc;
  @override
  @JsonKey(ignore: true)
  _$ExpenseCategoriesModelCopyWith<_ExpenseCategoriesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
