import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:threads_clone/controllers/profile_controller.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/widgets/circle_image.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController textEditingController =
      TextEditingController(text: "");
  final ProfileController controller = Get.find<ProfileController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    if (supabaseService.currentUser.value!.userMetadata?["description"] !=
        null) {
      textEditingController.text =
          supabaseService.currentUser.value!.userMetadata?["description"];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          Obx(
            () => TextButton(
                onPressed: () {
                  controller.updateProfile(
                      supabaseService.currentUser.value!.id,
                      textEditingController.text);
                },
                child: controller.loading.value
                    ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Done')),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
              () => Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleImage(
                    radius: 80,
                    file: controller.image.value,
                    url: supabaseService
                        .currentUser.value!.userMetadata?["image"],
                  ),
                  IconButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    icon: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white70,
                        child: Icon(Icons.edit)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Your description",
                  label: Text("Description")),
            )
          ],
        ),
      ),
    );
  }
}
