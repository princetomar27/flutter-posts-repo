import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/database_helper.dart';
import '../models/post.dart';

class PostProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Post> _posts = [];
  bool _isLoading = true;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchAndStorePosts() async {
    try {
      final localPosts = await _dbHelper.fetchPosts();
      if (localPosts.isNotEmpty) {
        _posts = localPosts;
      } else {
        final response = await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
        if (response.statusCode == 200) {
          final List<dynamic> postData = json.decode(response.body);
          List<Post> fetchedPosts =
              postData.map((json) => Post.fromJson(json)).toList();
          await _dbHelper.insertPosts(fetchedPosts);
          _posts = fetchedPosts;
        }
      }
    } catch (error) {
      print('Error fetching posts: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
