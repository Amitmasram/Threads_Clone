import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/routes/route_names.dart';

class PostCardBottomBar extends StatelessWidget {
  final PostModel post;
  const PostCardBottomBar({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(RouteNames.addReply, arguments: post);
              },
              icon: const Icon(Icons.comment_bank_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send_outlined),
            )
          ],
        ),
        Row(
          children: [
            Text("${post.commentCount} replies"),
            const SizedBox(
              width: 10,
            ),
            Text("${post.likeCount} likes")
          ],
        ),
      ],
    );
  }
}
