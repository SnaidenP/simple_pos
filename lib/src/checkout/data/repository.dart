import 'package:mysql1/mysql1.dart';
import 'package:simple_pos/src/checkout/models/client.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/checkout/models/ncftype.dart';
import 'package:simple_pos/src/config/database.dart';

abstract class CheckoutRepository {
  Future<List<Client>> getClients([String? client]);
  Future<List<NcfType>> getNfcTypes([String? ncf]);
  Future<Results> createInvoice(Invoice invoice);
  Future<Results> createClient(Client client);
  Future<List<Invoice>> getInvoices();
  Future<Results> updateNcfType(String ncfType);
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

  @override
  Future<Results> createClient(Client client) async {
    try {
      final results = await database.createClient(client);
      return results;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<NcfType>> getNfcTypes([String? ncf]) async {
    try {
      final results = await database.getNfcTypes(ncf);
      return results.map((e) => NcfType.fromJson(e.fields)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Invoice>> getInvoices() async {
    final invoice = await database.getInvoices();
    return invoice.map((e) => Invoice.fromJson(e.fields)).toList();
  }

  @override
  Future<Results> updateNcfType(String ncfType) async {
    try {
      final results = await database.updateNcf(ncfType);
      return results;
    } catch (e) {
      return Future.error(e);
    }
  }
}
