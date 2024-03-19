import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_pos/src/checkout/cubit/client_cubit.dart';
import 'package:simple_pos/src/checkout/cubit/cubit/select_client_cubit.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/config/constants.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/pos/cubit/cubit/cart_cubit.dart';
import 'package:simple_pos/src/pos/cubit/products_cubit.dart';
import 'package:simple_pos/src/pos/data/repository.dart';
import 'package:simple_pos/src/checkout/views/checkout_screen.dart';
import 'package:simple_pos/src/pos/widgets/product_in_cart.dart';
import 'package:simple_pos/src/pos/widgets/products_widgets.dart';
import 'package:simple_pos/src/pos/widgets/sidebar.dart';
import 'package:simple_pos/src/pos/widgets/textfield_search_producs.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductsCubit(ProductsRepository(context.read<Database>()))
                ..loadProducts(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: const PosScreen(),
    );
  }
}

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const SideBar(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PUNTO DE VENTA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const Text('Initial'),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          loaded: (products) => Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ProductsWidget(
                                  productName: products[index].name,
                                  productType: products[index].productType,
                                  productPrice: products[index].price,
                                  productStock: products[index].stock,
                                  onTap: () => context
                                      .read<CartCubit>()
                                      .addProductToCart(
                                        products[index],
                                      ),
                                );
                              },
                            ),
                          ),
                          error: Text.new,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SearchProductField(
                  onChanged: (value) {
                    context.read<ProductsCubit>().loadProducts(value);
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4.5,
                  height: MediaQuery.sizeOf(context).height - 150,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Text(
                                'Producto',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Cantidad',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 40),
                              Text(
                                'Precio',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return state.when(
                                initial: (_) => const Center(
                                  child: Text('No hay productos en el carrito'),
                                ),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                loaded: (products) => Expanded(
                                  child: ListView.builder(
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      return ProductsInCart(
                                        productName: products[index].name,
                                        quantity: products[index].quantity,
                                        price: products[index].price,
                                        onTap: () => context
                                            .read<CartCubit>()
                                            .removeProductFromCart(
                                              products[index].id,
                                            ),
                                        onLongPress: () => context
                                            .read<CartCubit>()
                                            .removeProductFromCartAll(
                                              products[index].id,
                                            ),
                                      );
                                    },
                                  ),
                                ),
                                error: Text.new,
                              );
                            },
                          ),
                        ),
                        Text(
                          'Total: \$${context.select(
                                (CartCubit cubit) => cubit.totalPrice,
                              ).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  context.read<CartCubit>().clearCart(),
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  final products = Provider.of<CartCubit>(
                                    context,
                                    listen: false,
                                  ).state.maybeWhen(
                                        initial: (products) => products,
                                        loaded: (products) => products,
                                        orElse: () => <ProductsInCart>[],
                                      );
                                  if (products.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        showCloseIcon: true,
                                        duration: Duration(seconds: 1),
                                        content: Center(
                                          child: Text(
                                            'El carrito no puede estar vacio',
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    final cubit = context.read<CartCubit>();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute<Widget>(
                                        builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) => ClientCubit(
                                                CheckoutRepositoryImpl(
                                                  database:
                                                      context.read<Database>(),
                                                ),
                                              ),
                                            ),
                                            BlocProvider.value(
                                              value: cubit,
                                            ),
                                          ],
                                          child: const CheckOutScreen(),
                                        ),
                                      ),
                                      (Route<dynamic> route) => true,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Pagar',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
