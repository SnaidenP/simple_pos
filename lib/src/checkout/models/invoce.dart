import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoce.freezed.dart';
part 'invoce.g.dart';

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    required String client,
    required String ncf,
    required String vendedor,
    required String date,
    required String products,
    required String metodoPago,
    required double total,
    int? id,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}
