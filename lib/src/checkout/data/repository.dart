import 'package:mysql1/mysql1.dart';
import 'package:simple_pos/src/checkout/models/client.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/config/database.dart';

abstract class CheckoutRepository {
  Future<List<Client>> getClients([String? client]);
  Future<Results> createInvoice(Invoice invoice);
}

class CheckoutRepositoryImpl implements CheckoutRepository {
  CheckoutRepositoryImpl({required this.database});

  final Database database;

  @override
  Future<List<Client>> getClients([String? client]) {
    try {
      final results = database.getClients(client);
      return results.then((value) {
        return value.map((e) => Client.fromJson(e.fields)).toList();
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Results> createInvoice(Invoice invoice) async {
    try {
      print('invoice 2: $invoice');
      final results = await database.createInvoice(invoice);
      return results;
    } catch (e) {
      return Future.error(e);
    }
  }
}
