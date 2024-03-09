import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/pos/cubit/products_cubit.dart';
import 'package:simple_pos/src/pos/data/repository.dart';
import 'package:simple_pos/src/pos/widgets/products_widgets.dart';
import 'package:simple_pos/src/pos/widgets/sidebar.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsCubit(ProductsRepository(context.read<Database>()))
            ..loadProducts(),
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
                const Text('POS Screen'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
