import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/services/storage_service.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/helper.dart';
import 'package:threads_clone/utils/storage_keys.dart';

class AuthController extends GetxController {
  var registerLoading = false.obs;
  var loginLoading = false.obs;

  Future<void> register(String name, String email, String password) async {
    try {
      registerLoading.value = true;
      final AuthResponse data = await SupabaseService.client.auth
          .signUp(email: email, password: password, data: {
        "name": name,
      });
      registerLoading.value = false;
      if (data.user != null) {
        StorageService.session
            .write(Storagekeys.userSession, data.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (error) {
      registerLoading.value = false;
      showSnackBar("Error", error.message);
    }
  }

  // * Login User
  Future<void> login(String email, String password) async {
    try {
      final AuthResponse response = await SupabaseService.client.auth
          .signInWithPassword(email: email, password: password);
      StorageService.session
          .write(Storagekeys.userSession, response.session!.toJson());
      Get.offAllNamed(RouteNames.home);
    } on AuthException catch (error) {
      showSnackBar("Error", error.message);
    }
  }
}
