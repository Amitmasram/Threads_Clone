import 'package:get/get.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/services/storage_service.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/storage_keys.dart';

class SettingController extends GetxController {
  void logout() async {
    //*  remove user session from local storage
    StorageService.session.remove(Storagekeys.userSession);
    await SupabaseService.client.auth.signOut();
    Get.offAllNamed(RouteNames.login);
  }
}
