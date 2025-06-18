import 'package:postgres/postgres.dart';

class DatabaseService {
  late PostgreSQLConnection _connection;

  DatabaseService({
    required String host,
    required int port,
    required String databaseName,
    required String username,
    required String password,
  }) {
    _connection = PostgreSQLConnection(
      host,
      port,
      databaseName,
      username: username,
      password: password,
      useSSL: true, // Neon memerlukan SSL
      timeoutInSeconds: 30,
    );
  }

  Future<void> connect() async {
    try {
      await _connection.open();
      print('Connected to Neon PostgreSQL');
    } catch (e) {
      print('Error connecting to database: $e');
    }
  }

  // Mengambil daftar buku
  Future<List<Map<String, dynamic>>> getBooks() async {
    try {
      var results = await _connection.query('SELECT * FROM books');
      return results
          .map(
            (row) => {
              'id': row[0],
              'title': row[1],
              'author': row[2],
              'price': row[3],
              'isbn': row[4],
            },
          )
          .toList();
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  // Menambahkan pelanggan
  Future<void> addCustomer(String name, String email) async {
    try {
      await _connection.query(
        'INSERT INTO customers (name, email) VALUES (@name, @email) RETURNING id',
        substitutionValues: {'name': name, 'email': email},
      );
      print('Customer added successfully');
    } catch (e) {
      print('Error adding customer: $e');
    }
  }

  Future<void> close() async {
    await _connection.close();
    print('Database connection closed');
  }
}
