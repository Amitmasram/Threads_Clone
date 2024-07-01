import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:threads_clone/views/home/home_page.dart';
import 'package:threads_clone/views/notifications/notification_page.dart';
import 'package:threads_clone/views/profile/profile_page.dart';
import 'package:threads_clone/views/search/search_page.dart';
import 'package:threads_clone/views/threads/add_threads.dart';

class Navigationservice extends GetxService {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  // all pages
  List<Widget> pages() {
    return [
      HomePage(),
      const SearchPage(),
      AddThreadsPage(),
      const NotificationPage(),
      const ProfilePage()
    ];
  }

  // update index
  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

// * Back to previeous page
  void backToPrevPage() {
    currentIndex.value = previousIndex.value;
  }
}
