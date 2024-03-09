import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/pos/models/product.dart';

class ProductsRepository {
  ProductsRepository(this.database);

  final Database database;

  Future<List<Product>> getProducts() async {
    final products = await database.getProducts();
    return products.map((e) => Product.fromJson(e.fields)).toList();
  }
}
