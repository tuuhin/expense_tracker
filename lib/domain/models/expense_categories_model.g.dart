// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoriesModel _$ExpenseCategoriesModelFromJson(
        Map<String, dynamic> json) =>
    ExpenseCategoriesModel(
      id: json['id'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$ExpenseCategoriesModelToJson(
        ExpenseCategoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
    };
