import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/pos/models/product.dart';
import 'package:simple_pos/src/pos/models/products_in_cart.dart';

part 'cart_state.dart';
part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.initial([]));

  void addProductToCart(Product product) {
    final productsList = state.maybeWhen(
      initial: (products) => products,
      loaded: (products) => products,
      orElse: () => <ProductsInCart>[],
    );
    final productInCart = ProductsInCart(
      id: product.id,
      name: product.name,
      price: product.price,
      quantity: 1,
    );

    final index =
        productsList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      final newList = productsList.map((e) {
        if (e.id == product.id) {
          return e.copyWith(quantity: e.quantity + 1);
        }
        return e;
      }).toList();
      emit(CartState.loaded(newList));
      return;
    }

    final newList = [...productsList, productInCart];
    emit(CartState.loaded(newList));
  }

  void removeProductFromCart(int productId) {
    final productsList = state.maybeWhen(
      initial: (products) => products,
      loaded: (products) => products,
      orElse: () => <ProductsInCart>[],
    );

    final index = productsList.indexWhere((element) => element.id == productId);
    if (index != -1 && productsList[index].quantity <= 1) {
      final newList =
          productsList.where((element) => element.id != productId).toList();
      emit(CartState.loaded(newList));
      return;
    }

    if (index != -1) {
      final newList = productsList.map((e) {
        if (e.id == productId) {
          return e.copyWith(quantity: e.quantity - 1);
        }
        return e;
      }).toList();
      emit(CartState.loaded(newList));
      return;
    }
  }

  // remove product from cart whatever the quantity is
  void removeProductFromCartAll(int productId) {
    final productsList = state.maybeWhen(
      initial: (products) => products,
      loaded: (products) => products,
      orElse: () => <ProductsInCart>[],
    );

    final index = productsList.indexWhere((element) => element.id == productId);
    if (index != -1) {
      final newList =
          productsList.where((element) => element.id != productId).toList();
      emit(CartState.loaded(newList));
      return;
    }
  }

  double get totalPrice {
    final productsList = state.maybeWhen(
      initial: (products) => products,
      loaded: (products) => products,
      orElse: () => <ProductsInCart>[],
    );

    return productsList.fold<double>(
      0,
      (previousValue, element) =>
          previousValue + element.price * element.quantity,
    );
  }

  void clearCart() {
    emit(const CartState.initial([]));
  }
}
