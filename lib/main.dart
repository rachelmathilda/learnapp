import 'package:flutter/material.dart';
import 'package:learnapp/services/database.dart';

void main() {
  final dbService = DatabaseService(
    host: const String.fromEnvironment('DB_HOST'),
    port: int.parse(
      const String.fromEnvironment('DB_PORT', defaultValue: '5432'),
    ),
    databaseName: const String.fromEnvironment('DB_NAME'),
    username: const String.fromEnvironment('DB_USERNAME'),
    password: const String.fromEnvironment('DB_PASSWORD'),
  );

  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {
  final DatabaseService dbService;

  const MyApp({required this.dbService, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(dbService: dbService));
  }
}

class HomeScreen extends StatefulWidget {
  final DatabaseService dbService;

  const HomeScreen({required this.dbService, super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    await widget.dbService.connect();
    final fetchedBooks = await widget.dbService.getBooks();
    setState(() {
      books = fetchedBooks;
    });
  }

  @override
  void dispose() {
    widget.dbService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookbite')),
      body:
          books.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return ListTile(
                    title: Text(book['title']),
                    subtitle: Text('By ${book['author']} - \$${book['price']}'),
                    trailing: Text('ISBN: ${book['isbn']}'),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await widget.dbService.addCustomer(
            'Jane Doe',
            'jane.doe@example.com',
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Customer added')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
