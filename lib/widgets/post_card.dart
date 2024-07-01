import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/routes/route_names.dart';

import 'package:threads_clone/widgets/circle_image.dart';
import 'package:threads_clone/widgets/post_card_bottombar.dart';
import 'package:threads_clone/widgets/post_card_image.dart';
import 'package:threads_clone/widgets/post_top_bar.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: CircleImage(
                  url: post.user?.metadata?.image,
                ),
              ),
              SizedBox(
                width: context.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostTopBar(post: post),
                    GestureDetector(
                        onTap: () => {
                              Get.toNamed(RouteNames.showThread,
                                  arguments: post.id)
                            },
                        child: Text(post.content!)),
                    const SizedBox(
                      height: 10,
                    ),
                    if (post.image != null)
                      GestureDetector(
                          onTap: () => {
                                Get.toNamed(RouteNames.showImage,
                                    arguments: post.image)
                              },
                          child: PostCardImage(url: post.image!)),
                    PostCardBottomBar(post: post),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 104, 104, 104),
          )
        ],
      ),
    );
  }
}
