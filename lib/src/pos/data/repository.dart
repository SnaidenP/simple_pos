import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/pos/models/product.dart';

class ProductsRepository {
  ProductsRepository(this.database);

  final Database database;

  Future<List<Product>> getProducts([String? search]) async {
    final products = await database.getProducts(search);
    return products.map((e) => Product.fromJson(e.fields)).toList();
  }

  // Get invoces
  Future<List<Invoice>> getInvoices() async {
    final invoice = await database.getInvoices();
    return invoice.map((e) => Invoice.fromJson(e.fields)).toList();
  }
}
