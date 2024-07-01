import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/notification_controller.dart';
import 'package:threads_clone/services/navigation_service.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/helper.dart';
import 'package:threads_clone/widgets/circle_image.dart';
import 'package:threads_clone/widgets/loading.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationController controller = Get.put(NotificationController());
  @override
  void initState() {
    controller
        .fetchNotifications(Get.find<SupabaseService>().currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<Navigationservice>().backToPrevPage();
            },
            icon: const Icon(Icons.close),
          ),
          title: const Text("Notification"),
        ),
        body: SingleChildScrollView(
          child: Obx(() => controller.loading.value
              ? Loading()
              : Column(
                  children: [
                    if (controller.notifications.isNotEmpty)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.notifications.length,
                          itemBuilder: (context, index) => ListTile(
                                leading: CircleImage(
                                  url: controller.notifications[index].user!
                                      .metadata!.image,
                                ),
                                title: Text(controller.notifications[index]
                                    .user!.metadata!.name!),
                                trailing: Text(formateDateFromNow(controller
                                    .notifications[index].createdAt!)),
                                subtitle: Text(controller
                                    .notifications[index].notification!),
                              ))
                    else
                      const Text("No Notification found")
                  ],
                )),
        ));
  }
}
