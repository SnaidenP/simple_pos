import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pos/src/checkout/cubit/client_cubit.dart';
import 'package:simple_pos/src/checkout/cubit/cubit/select_client_cubit.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/checkout/widgets/client_card.dart';
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

class SelectClients extends StatelessWidget {
  const SelectClients({super.key});

  @override
  Widget build(BuildContext context) {
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
                      return const Center(
                        child: Text('No se encontraron clientes'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.clients.length,
                      itemBuilder: (context, index) {
                        final client = state.clients[index];
                        return ClientCard(
                          client: client,
                          onTap: () {
                            // Seleccinar cliente
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
