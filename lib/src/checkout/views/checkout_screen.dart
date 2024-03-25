import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/src/checkout/cubit/cubit/invoce_cubit.dart';
import 'package:simple_pos/src/checkout/cubit/cubit/select_client_cubit.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/checkout/widgets/select_clients.dart';
import 'package:simple_pos/src/config/database.dart';
import 'package:simple_pos/src/config/pdf_invoce.dart';
import 'package:simple_pos/src/pos/cubit/cubit/cart_cubit.dart';
import 'package:simple_pos/src/pos/models/products_in_cart.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectClientCubit>(
          create: (context) => SelectClientCubit(),
        ),
        BlocProvider<InvoceCubit>(
          create: (_) => InvoceCubit(
            CheckoutRepositoryImpl(database: context.read<Database>()),
          ),
        ),
      ],
      child: const CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final textFieldTotalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Checkout Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecciona un cliente',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        final cubit = context.read<SelectClientCubit>();
                        showModalBottomSheet<Widget>(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: const SelectClientsModal(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            // cliente seleccionado
                            BlocBuilder<SelectClientCubit, SelectClientState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  loaded: (client) => Text(client.name),
                                  orElse: () =>
                                      const Text('Selecciona un cliente'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Select Payment Method
                const Text(
                  'Selecciona un método de pago',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                const DropdownMenu(
                  label: Text('Método de pago'),
                  dropdownMenuEntries: <DropdownMenuEntry>[
                    DropdownMenuEntry(
                      label: 'Efectivo',
                      value: 'cash',
                    ),
                    DropdownMenuEntry(
                      label: 'Transferencia',
                      value: 'transfer',
                    ),
                    DropdownMenuEntry(
                      label: 'Cheque',
                      value: 'check',
                    ),
                    DropdownMenuEntry(
                      label: 'Tarjeta de crédito',
                      value: 'credit_card',
                    ),
                  ],
                ),
                // Textfield que dice cuando el cliente pago
                const SizedBox(height: 16),
                const Text(
                  'Monto pagado',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: 180,
                  height: 50,
                  child: TextField(
                    controller: textFieldTotalController,
                    onChanged: (value) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Monto pagado',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const Spacer(),
                const Text(
                  'Total a devolver',
                  style: TextStyle(fontSize: 24),
                ),

                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded: (products) {
                        final total = products.fold<double>(
                          0,
                          (previousValue, element) =>
                              previousValue + element.price,
                        );
                        final totalPaid = double.tryParse(
                          textFieldTotalController.text,
                        );
                        if (totalPaid != null) {
                          return Text(
                            (totalPaid - total).toStringAsFixed(2),
                            style: const TextStyle(fontSize: 24),
                          );
                        }
                        return const Text('0.00');
                      },
                      orElse: () =>
                          const Text('Error no hay productos en el carrito'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // Total
                SizedBox(
                  width: 300,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      final products =
                          context.read<CartCubit>().state.maybeWhen(
                                loaded: (products) => products,
                                orElse: () => <ProductsInCart>[],
                              );
                      final selectedClient =
                          context.read<SelectClientCubit>().state.maybeWhen(
                                loaded: (client) => client,
                                orElse: () => null,
                              );
                      if (products.isEmpty || selectedClient == null) {
                        Navigator.pop(context);
                      } else {
                        final total = products.fold<double>(
                          0,
                          (previousValue, element) =>
                              previousValue + element.price,
                        );
                        final invoce = Invoce(
                          client: selectedClient,
                          products: products,
                          total: total,
                        );
                        context.read<InvoceCubit>().createInvoice(
                              Invoice(
                                client: selectedClient.name,
                                date: DateTime.now().toString(),
                                products: products.toString(),
                                total: total,
                              ),
                            );

                        showDialog<AlertDialog>(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('¿Desea un PDF de la factura?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<InvoceCubit>()
                                        .createPdf(invoce);
                                    context.read<CartCubit>().clearCart();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Si'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<CartCubit>().clearCart();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Pagar',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                ),
              ],
            ),
            // Product List
            const Spacer(),
            const VerticalDivider(),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Productos',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loaded: (products) => Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ListTile(
                                title: Text(product.name),
                                subtitle: Text(product.price.toString()),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .removeProductFromCart(product.id);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        orElse: () => const Text('No hay productos'),
                      );
                    },
                  ),
                  // Total a devolver

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16),
                      const Text(
                        'Sub-total',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loaded: (products) {
                              final total = products.fold<double>(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.price,
                              );
                              return Text(
                                (total * 0.82).toStringAsFixed(2),
                                style: const TextStyle(fontSize: 24),
                              );
                            },
                            orElse: () => const Text(
                              'Error no hay productos en el carrito',
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'ITEBIS',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loaded: (products) {
                              final total = products.fold<double>(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.price,
                              );
                              return Text(
                                (total * 0.18).toStringAsFixed(2),
                                style: const TextStyle(fontSize: 24),
                              );
                            },
                            orElse: () => const Text(
                              'Error no hay productos en el carrito',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loaded: (products) {
                          final total = products.fold<double>(
                            0,
                            (previousValue, element) =>
                                previousValue + element.price,
                          );
                          return Text(total.toStringAsFixed(2));
                        },
                        orElse: () =>
                            const Text('Error no hay productos en el carrito'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
