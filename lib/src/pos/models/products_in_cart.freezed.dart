// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_in_cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductsInCart _$ProductsInCartFromJson(Map<String, dynamic> json) {
  return _ProductsInCart.fromJson(json);
}

/// @nodoc
mixin _$ProductsInCart {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductsInCartCopyWith<ProductsInCart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsInCartCopyWith<$Res> {
  factory $ProductsInCartCopyWith(
          ProductsInCart value, $Res Function(ProductsInCart) then) =
      _$ProductsInCartCopyWithImpl<$Res, ProductsInCart>;
  @useResult
  $Res call({int id, String name, double price, int quantity});
}

/// @nodoc
class _$ProductsInCartCopyWithImpl<$Res, $Val extends ProductsInCart>
    implements $ProductsInCartCopyWith<$Res> {
  _$ProductsInCartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductsInCartImplCopyWith<$Res>
    implements $ProductsInCartCopyWith<$Res> {
  factory _$$ProductsInCartImplCopyWith(_$ProductsInCartImpl value,
          $Res Function(_$ProductsInCartImpl) then) =
      __$$ProductsInCartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, double price, int quantity});
}

/// @nodoc
class __$$ProductsInCartImplCopyWithImpl<$Res>
    extends _$ProductsInCartCopyWithImpl<$Res, _$ProductsInCartImpl>
    implements _$$ProductsInCartImplCopyWith<$Res> {
  __$$ProductsInCartImplCopyWithImpl(
      _$ProductsInCartImpl _value, $Res Function(_$ProductsInCartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_$ProductsInCartImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductsInCartImpl implements _ProductsInCart {
  const _$ProductsInCartImpl(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity});

  factory _$ProductsInCartImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductsInCartImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final double price;
  @override
  final int quantity;

  @override
  String toString() {
    return 'ProductsInCart(id: $id, name: $name, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsInCartImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, price, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsInCartImplCopyWith<_$ProductsInCartImpl> get copyWith =>
      __$$ProductsInCartImplCopyWithImpl<_$ProductsInCartImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductsInCartImplToJson(
      this,
    );
  }
}

abstract class _ProductsInCart implements ProductsInCart {
  const factory _ProductsInCart(
      {required final int id,
      required final String name,
      required final double price,
      required final int quantity}) = _$ProductsInCartImpl;

  factory _ProductsInCart.fromJson(Map<String, dynamic> json) =
      _$ProductsInCartImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  double get price;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ProductsInCartImplCopyWith<_$ProductsInCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
