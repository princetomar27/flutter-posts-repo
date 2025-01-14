import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, body TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertPosts(List<Post> posts) async {
    final db = await database;
    for (var post in posts) {
      await db.insert('posts', post.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Post>> fetchPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> posts = await db.query('posts');
    return List.generate(posts.length, (i) {
      return Post(
        id: posts[i]['id'],
        title: posts[i]['title'],
        body: posts[i]['body'],
      );
    });
  }
}
