import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/models/reply_model.dart';
import 'package:threads_clone/widgets/circle_image.dart';

class ReplyCard extends StatelessWidget {
  final ReplyModel reply;
  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleImage(
                url: reply.user!.metadata?.image,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: context.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ReplyCard(reply: reply), Text(reply.reply!)],
                ))
          ],
        ),
        const Divider(
          color: Color.fromARGB(255, 104, 104, 104),
        )
      ],
    );
  }
}

class ReplyCar2 extends StatelessWidget {
  const ReplyCar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('repakjdjka')],
    );
  }
}
