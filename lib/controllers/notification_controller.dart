import 'package:get/get.dart';
import 'package:threads_clone/models/notification_model.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/helper.dart';

class NotificationController extends GetxController {
  var loading = false.obs;
  RxList<NotificationModel> notifications = RxList<NotificationModel>();
  void fetchNotifications(String userId) async {
    try {
      loading.value = true;
      final List<dynamic> response = await SupabaseService.client
          .from("notifications")
          .select(''
              'id,post_id, notification,created_at, user_id, user:user_id(email, metadata)'
              '')
          .eq("to_user_id", userId)
          .order("id", ascending: false);
      if (response.isNotEmpty) {
        notifications.value = [
          for (var item in response) NotificationModel.fromJson(item)
        ];
      }
      loading.value = false;
      // print("The notification response is ${jsonEncode(response)}");
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong.Please try again!");
    }
  }
}
