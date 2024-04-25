// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ncftype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NcfTypeImpl _$$NcfTypeImplFromJson(Map<String, dynamic> json) =>
    _$NcfTypeImpl(
      id: json['id'] as int,
      tipo: json['tipo'] as String,
      constante: json['constante'] as int,
      numeroInicial: json['numeroInicial'] as String,
      limite: json['limite'] as int,
    );

Map<String, dynamic> _$$NcfTypeImplToJson(_$NcfTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tipo': instance.tipo,
      'constante': instance.constante,
      'numeroInicial': instance.numeroInicial,
      'limite': instance.limite,
    };
