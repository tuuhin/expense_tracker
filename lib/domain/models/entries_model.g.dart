// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntriesModel _$EntriesModelFromJson(Map<String, dynamic> json) => EntriesModel(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      desc: json['desc'] as String?,
      isSecure: json['isSecure'] as bool?,
    );

Map<String, dynamic> _$EntriesModelToJson(EntriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'desc': instance.desc,
      'isSecure': instance.isSecure,
    };
