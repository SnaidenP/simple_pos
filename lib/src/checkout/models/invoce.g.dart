// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      client: json['client'] as String,
      ncf: json['ncf'] as String,
      vendedor: json['vendedor'] as String,
      date: json['date'] as String,
      products: json['products'] as String,
      metodoPago: json['metodoPago'] as String,
      total: (json['total'] as num).toDouble(),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'client': instance.client,
      'ncf': instance.ncf,
      'vendedor': instance.vendedor,
      'date': instance.date,
      'products': instance.products,
      'metodoPago': instance.metodoPago,
      'total': instance.total,
      'id': instance.id,
    };
