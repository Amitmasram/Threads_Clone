import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/thread_controller.dart';
import 'package:threads_clone/widgets/post_card.dart';

import '../../widgets/loading.dart';
import '../../widgets/reply_card.dart';

class ShowThreads extends StatefulWidget {
  const ShowThreads({super.key});

  @override
  State<ShowThreads> createState() => _ShowThreadsState();
}

class _ShowThreadsState extends State<ShowThreads> {
  final int postId = Get.arguments;
  final ThreadController controller = Get.put(ThreadController());

  @override
  void initState() {
    controller.show(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Show Threads")),
      body: Obx(() => controller.showThreadLoadig.value
          ? Loading()
          : SingleChildScrollView(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  PostCard(post: controller.post.value),
                  SizedBox(
                    height: 20,
                  ),
                  // * Load post replies
                  if (controller.showReplyLoadig.value)
                    Loading()
                  else if (controller.replies.isNotEmpty)
                    ListView.builder(
                      itemCount: controller.replies.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ReplyCard(reply: controller.replies[index]),
                    )
                ],
              ),
            )),
    );
  }
}
