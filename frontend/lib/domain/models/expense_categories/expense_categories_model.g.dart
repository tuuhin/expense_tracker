// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpenseCategoriesModel _$$_ExpenseCategoriesModelFromJson(
        Map<String, dynamic> json) =>
    _$_ExpenseCategoriesModel(
      id: json['id'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$$_ExpenseCategoriesModelToJson(
        _$_ExpenseCategoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
    };
