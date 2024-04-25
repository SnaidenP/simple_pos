import 'package:mysql1/mysql1.dart';
import 'package:simple_pos/src/checkout/models/client.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/config/constants.dart';

class Database {
  Database() {
    _connect();
  }

  late MySqlConnection _connection;

  Future<void> _connect() async {
    _connection = await MySqlConnection.connect(
      ConnectionSettings(
        user: userDatabase,
        db: databaseName,
      ),
    );
  }

  Future<Results> getUser(String username, String password) async {
    try {
      return await _connection.query(
        'SELECT * FROM users WHERE username = ? AND password = SHA2(?, 256)',
        [username, password],
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Results> registerUser(
    String username,
    String password,
    String name,
  ) async {
    try {
      return await _connection.query(
        '''INSERT INTO users (username, password, name) VALUES (?, SHA2(?, 256), ?)''',
        [username, password, name],
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Results> getProducts([String? product]) async {
    try {
      if (product != null) {
        final result = await _connection.query(
          'SELECT * FROM products WHERE name LIKE ?',
          ['%$product%'],
        );
        return result;
      }
      return await _connection.query('SELECT * FROM products');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Results> getClients([String? client]) async {
    try {
      if (client != null) {
        final result = await _connection.query(
          'SELECT * FROM clients WHERE name LIKE ? OR rnc LIKE ?',
          ['%$client%', '%$client%'],
        );
        return result;
      }
      return await _connection.query('SELECT * FROM clients');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Results> createInvoice(Invoice invoce) async {
    try {
      return await _connection.query(
        'INSERT INTO invoce (ncf, vendedor, client, date, products, metodo_pago, total) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [
          invoce.ncf,
          invoce.vendedor,
          invoce.client,
          invoce.date,
          invoce.products,
          invoce.metodoPago,
          invoce.total,
        ],
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Results> createClient(Client client) async {
    try {
      return await _connection.query(
        'INSERT INTO clients (name, rnc, phone) VALUES (?, ?, ?)',
        [client.name, client.rnc, client.phone],
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Results> getNfcTypes([String? ncf]) async {
    try {
      if (ncf != null) {
        final result = await _connection.query(
          'SELECT * FROM ncf_types WHERE ncf LIKE ?',
          ['%$ncf%'],
        );
        return result;
      }
      return await _connection.query('SELECT * FROM ncf_types');
    } catch (e) {
      return Future.error(e);
    }
  }

  // Sumar 1 a la constante de un ncf
  Future<Results> updateNcf(String ncf) async {
    try {
      return await _connection.query(
        'UPDATE ncf_types SET constante = constante + 1 WHERE tipo = ?',
        [ncf],
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Results> getInvoices() async {
    try {
      return await _connection.query('SELECT * FROM invoce');
    } catch (e) {
      return Future.error(e);
    }
  }
}
