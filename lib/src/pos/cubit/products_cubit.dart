import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/pos/models/product.dart';
import 'package:simple_pos/src/pos/data/repository.dart';

part 'products_state.dart';
part 'products_cubit.freezed.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.repository) : super(const ProductsState.initial());

  final ProductsRepository repository;
  // Load products from the database
  Future<void> loadProducts() async {
    emit(const ProductsState.loading());
    try {
      final products = await repository.getProducts();
      emit(
        ProductsState.loaded(
          products,
        ),
      );
    } catch (e) {
      emit(ProductsState.error(e.toString()));
    }
  }
}
