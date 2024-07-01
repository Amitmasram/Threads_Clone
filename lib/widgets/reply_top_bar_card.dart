import 'package:flutter/material.dart';

import 'package:threads_clone/models/reply_model.dart';
import 'package:threads_clone/utils/helper.dart';

class ReplyTopBarCard extends StatelessWidget {
  final ReplyModel reply;
  const ReplyTopBarCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        reply.user!.metadata!.name!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Text(formateDateFromNow(reply.createdAt!)),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.more_horiz)
        ],
      )
    ]);
  }
}
