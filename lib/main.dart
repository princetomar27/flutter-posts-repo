import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/post_provider.dart';
import 'ui/screens/post_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider()..fetchAndStorePosts(),
      child: const MaterialApp(
        title: 'Flutter API & SQLite Demo',
        home: PostListScreen(),
      ),
    );
  }
}
