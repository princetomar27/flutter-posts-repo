import 'package:flutter/material.dart';
import 'package:flutterpost/ui/widgets/post_widget.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.posts.isEmpty) {
            return const Center(
              child: Text(
                'No posts available.',
              ),
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.posts.length,
                    itemBuilder: (context, index) {
                      final post = provider.posts[index];
                      return PostWidget(post: post);
                    },
                  ),
                ),
                const SizedBox(height: 36),
              ],
            );
          }
        },
      ),
    );
  }
}
