import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/thread_controller.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/widgets/add_thread_appbar.dart';
import 'package:threads_clone/widgets/circle_image.dart';
import 'package:threads_clone/widgets/thread_image_preview.dart';

class AddThreadsPage extends StatelessWidget {
  AddThreadsPage({super.key});
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final ThreadController controller = Get.put(ThreadController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AddThreadAppBar(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => CircleImage(
                      url: supabaseService
                          .currentUser.value!.userMetadata?["image"],
                    )),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: context.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(supabaseService
                          .currentUser.value!.userMetadata?["name"])),
                      TextField(
                        autofocus: true,
                        controller: controller.contentController,
                        onChanged: (value) => controller.content.value = value,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 10,
                        minLines: 1,
                        maxLength: 1000,
                        decoration: const InputDecoration(
                          hintText: "type a thread",
                          border: InputBorder.none,
                        ),
                      ),
                      GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: const Icon(Icons.attach_file)),

                      // * To privew Image thread

                      Obx(() => Column(
                            children: [
                              if (controller.image.value != null)
                                ThreadImagePreview()
                            ],
                          ))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
