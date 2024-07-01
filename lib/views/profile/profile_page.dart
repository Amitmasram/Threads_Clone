import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:threads_clone/controllers/profile_controller.dart';
import 'package:threads_clone/routes/route_names.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/styles/button_style.dart';
import 'package:threads_clone/widgets/circle_image.dart';
import 'package:threads_clone/widgets/reply_card.dart';
import 'package:threads_clone/widgets/loading.dart';
import 'package:threads_clone/widgets/post_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  @override
  void initState() {
    if (supabaseService.currentUser.value?.id != null) {
      controller.fetchUserThreads(supabaseService.currentUser.value!.id);
      controller.fetchReplies(supabaseService.currentUser.value!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.language),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () => Get.toNamed(RouteNames.settings),
                icon: const Icon(Icons.sort))
          ],
        ),
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 160,
                      collapsedHeight: 160,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        supabaseService.currentUser.value!
                                            .userMetadata?["name"],
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: context.width * 0.70,
                                        child: Text(supabaseService.currentUser
                                                    .value?.userMetadata?[
                                                "description"] ??
                                            "threads clone."),
                                      )
                                    ],
                                  ),
                                ),
                                CircleImage(
                                  radius: 40,
                                  url: supabaseService.currentUser.value!
                                      .userMetadata?["image"],
                                )
                                //  CircleAvatar(
                                //   radius: 40,
                                //   backgroundImage: AssetImage(
                                //     "assets/images/avatar.png",
                                //   ),
                                // )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: OutlinedButton(
                                        onPressed: () =>
                                            Get.toNamed(RouteNames.editProfile),
                                        style: customOutlineStyle(),
                                        child: const Text("Edit Profile"))),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: OutlinedButton(
                                        onPressed: () {},
                                        style: customOutlineStyle(),
                                        child: const Text("Share Profile")))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                        floating: true,
                        pinned: true,
                        delegate: SliverAppBarDelegate(const TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: [
                              Tab(
                                text: "Threads",
                              ),
                              Tab(
                                text: "Replies",
                              )
                            ])))
                  ];
                }),
                body: TabBarView(
                  children: [
                    Obx(() => SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              if (controller.postLoading.value)
                                const Loading()
                              else if (controller.posts.isNotEmpty)
                                ListView.builder(
                                    itemCount: controller.posts.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: ((context, index) => PostCard(
                                        post: controller.posts[index])))
                              else
                                const Center(
                                  child: Text('No thread found'),
                                )
                            ],
                          ),
                        )),
                    Obx(() => SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              if (controller.replyLoading.value)
                                const Loading()
                              else if (controller.replies.isNotEmpty)
                                ListView.builder(
                                    itemCount: controller.replies.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        // ReplyCar2())
                                        ReplyCard(
                                            reply: controller.replies[index]))
                              else
                                const Center(
                                  child: Text("No reply found"),
                                )
                            ],
                          ),
                        ))
                  ],
                ))));
  }
}

//* Sliver PersistentHeader appBarr

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  SliverAppBarDelegate(this._tabBar);

  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
