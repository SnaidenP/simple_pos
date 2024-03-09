import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_in_cart.freezed.dart';
part 'products_in_cart.g.dart';

@freezed
class ProductsInCart with _$ProductsInCart {
  const factory ProductsInCart({
    required int id,
    required String name,
    required double price,
    required int quantity,
  }) = _ProductsInCart;

  factory ProductsInCart.fromJson(Map<String, dynamic> json) =>
      _$ProductsInCartFromJson(json);
}
