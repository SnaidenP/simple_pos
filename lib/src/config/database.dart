import 'package:mysql1/mysql1.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';

class Database {
  Database() {
    _connect();
  }

  late MySqlConnection _connection;

  Future<void> _connect() async {
    _connection = await MySqlConnection.connect(
      ConnectionSettings(
        user: 'root',
        db: 'simple_pos',
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
          'SELECT * FROM clients WHERE name LIKE ?',
          ['%$client%'],
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
        'INSERT INTO invoce (client, date, products, total) VALUES (?, ?, ?, ?)',
        [invoce.client, invoce.date, invoce.products, invoce.total],
      );
    } catch (e) {
      return Future.error(e);
    }
  }
}
