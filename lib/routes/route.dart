import 'package:get/get.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/views/auth/login.dart';
import 'package:threads_clone/views/auth/register.dart';
import 'package:threads_clone/views/home.dart';
import 'package:threads_clone/views/profile/edit_profile_page.dart';
import 'package:threads_clone/views/replies/add_reply.dart';
import 'package:threads_clone/views/settings/setting.dart';
import 'package:threads_clone/views/threads/show_image.dart';
import 'package:threads_clone/views/threads/show_thread.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => HomeScreen()),
    GetPage(
        name: RouteNames.login,
        page: () => const LoginScreen(),
        transition: Transition.fade),
    GetPage(
        name: RouteNames.register,
        page: () => const RegisterScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: RouteNames.editProfile,
        page: () => const EditProfilePage(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.settings,
        page: () => Setting(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteNames.addReply,
        page: () => AddReply(),
        transition: Transition.downToUp),
    GetPage(
        name: RouteNames.showThread,
        page: () => const ShowThreads(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.showImage,
        page: () => ShowImage(),
        transition: Transition.leftToRight),
  ];
}
