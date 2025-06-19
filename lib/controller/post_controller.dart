import 'package:get/get.dart';

import 'package:test_fox/model/post_model.dart';
import 'package:test_fox/services/api_service.dart';

class PostsController extends GetxController {
  RxBool isloading = false.obs;
  RxList<Posts> posts = <Posts>[].obs;
  final ApiService _apiService = ApiService();

  @override
  onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isloading(true);
      final fetchedPosts = await _apiService.fetchPosts();
      print(fetchedPosts[0].id);
      posts.assignAll(fetchedPosts);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isloading(false);
    }
  }
}
