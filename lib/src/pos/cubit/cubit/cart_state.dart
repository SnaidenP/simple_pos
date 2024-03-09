part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial(List<ProductsInCart> products) = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.loaded(List<ProductsInCart> products) = _Loaded;
  const factory CartState.error(String message) = _Error;
}
