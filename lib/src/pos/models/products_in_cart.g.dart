// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_in_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductsInCartImpl _$$ProductsInCartImplFromJson(Map<String, dynamic> json) =>
    _$ProductsInCartImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$$ProductsInCartImplToJson(
        _$ProductsInCartImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
    };
