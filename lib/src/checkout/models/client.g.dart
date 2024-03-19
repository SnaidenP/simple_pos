// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientImpl _$$ClientImplFromJson(Map<String, dynamic> json) => _$ClientImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      rnc: json['rnc'] as int,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$ClientImplToJson(_$ClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rnc': instance.rnc,
      'phone': instance.phone,
    };
