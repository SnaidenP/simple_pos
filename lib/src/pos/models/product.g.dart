// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      productType: json['productType'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productType': instance.productType,
      'price': instance.price,
      'stock': instance.stock,
    };
