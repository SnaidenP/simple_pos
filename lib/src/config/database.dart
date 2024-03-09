import 'package:mysql1/mysql1.dart';

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

  Future<Results> getProducts() async {
    try {
      final results = await _connection.query('SELECT * FROM products');
      return results;
    } catch (e) {
      return Future.error(e);
    }
  }
}
