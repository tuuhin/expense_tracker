// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeSourceModel _$IncomeSourceModelFromJson(Map<String, dynamic> json) =>
    IncomeSourceModel(
      id: json['id'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String?,
      isSecure: json['isSecure'] as bool?,
    );

Map<String, dynamic> _$IncomeSourceModelToJson(IncomeSourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'isSecure': instance.isSecure,
    };
