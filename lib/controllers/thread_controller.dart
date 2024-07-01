import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/services/navigation_service.dart';
import 'package:threads_clone/services/supabase_service.dart';
import 'package:threads_clone/utils/env.dart';
import 'package:threads_clone/utils/helper.dart';
import 'package:uuid/uuid.dart';

import '../models/post_model.dart';
import '../models/reply_model.dart';

class ThreadController extends GetxController {
  final TextEditingController contentController =
      TextEditingController(text: "");
  var content = "".obs;
  var loading = false.obs;

  Rx<File?> image = Rx<File?>(null);
  var showThreadLoadig = false.obs;
  Rx<PostModel> post = Rx<PostModel>(PostModel());

  var showReplyLoadig = false.obs;
  RxList<ReplyModel> replies = RxList<ReplyModel>();

  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) {
      image.value = file;
    }
  }

  void store(String userId) async {
    try {
      loading.value = true;
      const uuid = Uuid();
      final dir = "$userId/${uuid.v6()}";
      var imgPath = "";
      if (image.value != null && image.value!.existsSync()) {
        imgPath = await SupabaseService.client.storage
            .from(Env.s3Bucket)
            .upload(dir, image.value!);

        //* Add post  in DB
        await SupabaseService.client.from("posts").insert({
          "user_id": userId,
          "content": content.value,
          "image": imgPath.isNotEmpty ? imgPath : null
        });
        loading.value = false;
        resetState();
        Get.find<Navigationservice>().currentIndex.value = 0;

        showSnackBar("Success", "Post Added successfully!");
      }
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    } catch (error) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  /// * To show  post/ thread
  void show(int postId) async {
    try {
      post.value = PostModel();
      replies.value = [];
      showThreadLoadig.value = true;
      final response = await SupabaseService.client
          .from("posts")
          .select(
              "id, content, image, created_at, comment_count, like_count,user_id,user:user_id (email,metadata)")
          .eq("id", postId)
          .single();

      showThreadLoadig.value = false;
      post.value = PostModel.fromJson(response);

      // * Fetch post replies
      fectchPostReplies(postId);
    } catch (e) {
      showThreadLoadig.value = false;
      showSnackBar("Error", "Something went wrong");
    }
  }

  /// * Featch post replies
  void fectchPostReplies(int postId) async {
    try {
      showReplyLoadig.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("comments").select('''
id,user_id, post_id,reply,created_at,user:user_id (email,metadata)
''').eq("post_id", postId).order('id', ascending: false);
      showReplyLoadig.value = false;
      if (response.isNotEmpty) {
        replies.value = [for (var item in response) ReplyModel.fromJson(item)];
      }
    } catch (e) {
      showReplyLoadig.value = false;
      showSnackBar("Error", "Something went wrong");
    }
  }

  // * Reset the state
  void resetState() {
    content.value = "";
    contentController.text = "";
    image.value = null;
  }

  @override
  void onClose() {
    contentController.dispose();
    super.dispose();
  }
}
