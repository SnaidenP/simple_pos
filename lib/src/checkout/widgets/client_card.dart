import 'package:flutter/material.dart';
import 'package:simple_pos/src/checkout/models/client.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({
    required this.client,
    required this.onTap,
    super.key,
  });

  final Client client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          client.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RNC: ${client.rnc}', style: const TextStyle(fontSize: 12)),
            Text(
              'Teléfono: ${client.phone}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
