import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterpost/models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: generateRandomLightColor(),
      ),
      child: ListTile(
        title: Text(
          post.title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          post.body,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

Color generateRandomLightColor() {
  Random random = Random();
  int red = 160 + random.nextInt(55);
  int green = 160 + random.nextInt(55);
  int blue = 160 + random.nextInt(55);
  return Color.fromRGBO(red, green, blue, 0.5);
}
