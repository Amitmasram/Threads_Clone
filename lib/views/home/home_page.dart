import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/home_controller.dart';
import 'package:threads_clone/widgets/loading.dart';
import 'package:threads_clone/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () => controller.fetchThreads(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 40,
                    height: 40,
                  ),
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Obx(() => controller.loading.value
                    ? const Loading()
                    : ListView.builder(
                        itemCount: controller.posts.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) =>
                            PostCard(post: controller.posts[index])))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
