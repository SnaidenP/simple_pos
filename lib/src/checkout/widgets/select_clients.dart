import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/src/checkout/cubit/client_cubit.dart';
import 'package:simple_pos/src/checkout/cubit/cubit/select_client_cubit.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/checkout/models/client.dart';
import 'package:simple_pos/src/checkout/widgets/client_card.dart';
import 'package:simple_pos/src/config/constants.dart';
import 'package:simple_pos/src/config/database.dart';

class SelectClientsModal extends StatelessWidget {
  const SelectClientsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ClientCubit(
            CheckoutRepositoryImpl(database: context.read<Database>()),
          )..getClients(),
        ),
      ],
      child: const SelectClients(),
    );
  }
}

class SelectClients extends StatefulWidget {
  const SelectClients({super.key});

  @override
  State<SelectClients> createState() => _SelectClientsState();
}

class _SelectClientsState extends State<SelectClients> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    Timer? debounce;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Selecciona un cliente', style: TextStyle(fontSize: 24)),
          // Buscador de clientes
          SizedBox(
            width: 500,
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar cliente',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (debounce?.isActive ?? false) debounce?.cancel();
                debounce = Timer(const Duration(milliseconds: 500), () {
                  context.read<ClientCubit>().getClients(value);
                });
              },
            ),
          ),
          // Lista de clientes
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<ClientCubit, ClientState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  success: (state) {
                    if (state.clients.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('No se encontraron clientes'),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<ClientCubit>()
                                        .getClients(searchController.text);
                                  },
                                  child: const Text('Recargar'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              child: const Text('Crear Cliente'),
                              onPressed: () {
                                final nameController = TextEditingController();
                                final rncController = TextEditingController();
                                final phoneController = TextEditingController();

                                if (searchController.text.isNotEmpty &&
                                    int.tryParse(searchController.text) !=
                                        null) {
                                  rncController.text = searchController.text;
                                } else {
                                  nameController.text = searchController.text;
                                }
                                showModalBottomSheet<String>(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Crear Cliente',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: 500,
                                            child: TextFormField(
                                              controller: nameController,
                                              decoration: const InputDecoration(
                                                labelText: 'Nombre del cliente',
                                                prefixIcon: Icon(Icons.person),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: 500,
                                            child: TextFormField(
                                              controller: rncController,
                                              decoration: const InputDecoration(
                                                labelText: 'RNC',
                                                prefixIcon: Icon(Icons.numbers),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: 500,
                                            child: TextFormField(
                                              controller: phoneController,
                                              decoration: const InputDecoration(
                                                labelText: 'Teléfono',
                                                prefixIcon: Icon(Icons.phone),
                                              ),
                                              keyboardType: TextInputType.phone,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Validate form
                                              if (nameController.text.isEmpty ||
                                                  rncController.text.isEmpty ||
                                                  phoneController
                                                      .text.isEmpty) {
                                                // Show error message
                                                showDialog<void>(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('Error'),
                                                      content: const Text(
                                                        'Todos los campos '
                                                        'son requeridos',
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          },
                                                          child: const Text(
                                                            'Cerrar',
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                return;
                                              }
                                              context
                                                  .read<Database>()
                                                  .createClient(
                                                    Client(
                                                      name: nameController.text,
                                                      phone:
                                                          phoneController.text,
                                                      rnc: int.parse(
                                                        rncController.text,
                                                      ),
                                                    ),
                                                  );

                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Crear Cliente'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.clients.length,
                      itemBuilder: (context, index) {
                        final client = state.clients[index];
                        return ClientCard(
                          client: client,
                          onTap: () {
                            context
                                .read<SelectClientCubit>()
                                .loadClient(client);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  error: (error) => Center(
                    child: Text(error.message),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
