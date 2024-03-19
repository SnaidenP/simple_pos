import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/pos/models/products_in_cart.dart';

part 'invoce.freezed.dart';
part 'invoce.g.dart';

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    required String client,
    required String date,
    required String products,
    required double total,
    int? id,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}
