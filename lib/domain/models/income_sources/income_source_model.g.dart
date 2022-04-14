// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IncomeSourceModel _$$_IncomeSourceModelFromJson(Map<String, dynamic> json) =>
    _$_IncomeSourceModel(
      id: json['id'] as int,
      title: json['title'] as String,
      desc: json['desc'] as String?,
      isSecure: json['is_secure'] as bool?,
    );

Map<String, dynamic> _$$_IncomeSourceModelToJson(
        _$_IncomeSourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'is_secure': instance.isSecure,
    };
