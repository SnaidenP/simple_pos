// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      client: json['client'] as String,
      date: json['date'] as String,
      products: json['products'] as String,
      total: (json['total'] as num).toDouble(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'client': instance.client,
      'date': instance.date,
      'products': instance.products,
      'total': instance.total,
      'id': instance.id,
    };
