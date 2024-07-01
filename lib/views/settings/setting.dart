import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/setting_controller.dart';
import 'package:threads_clone/utils/helper.dart';

class Setting extends StatelessWidget {
  Setting({super.key});
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                confirmDialog("Are you sure",
                    "This action logout you from app.", controller.logout);
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
