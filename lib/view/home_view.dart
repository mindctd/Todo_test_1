import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:test_fox/controller/post_controller.dart';

import 'package:test_fox/view/detail.dart';

class PostsScreen extends StatelessWidget {
  final PostsController controller = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mind have 8 test kub"),
      ),
      body: Obx(
        () {
          if (controller.isloading.value) {
            EasyLoading.show(status: "Loading...");
            return const SizedBox();
          } else {
            EasyLoading.dismiss();
            return RefreshIndicator(
              onRefresh: () async {
                await controller.onInit;
                // await Future.delayed(Duration(
                //     milliseconds: 300));
              },
              child: ListView.builder(
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    final cleanBody = post.body.replaceAll("\n", "replace");
                    return InkWell(
                      onTap: () {
                        Get.to(Detail(posts: post));
                      },
                      child: Container(
                        width: 60,
                        height: 140,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Image.network(
                                  "https://picsum.photos/id/${post.id}/60",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      post.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(cleanBody,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:test_fox/controller/post_controller.dart';

// class PostScreen extends StatelessWidget {
//   final PostsController controller = Get.put(PostsController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Posts')),
//       body: Obx(() {
//         if (controller.isloading.value) {
//           EasyLoading.show(status: 'Loading...');
//           return const SizedBox(); // Don't build UI yet
//         } else {
//           EasyLoading.dismiss();
//           return RefreshIndicator(
//             onRefresh: controller.fetchPosts,
//             child: ListView.builder(
//               itemCount: controller.posts.length,
//               itemBuilder: (context, index) {
//                 final post = controller.posts[index];
//                 return ListTile(
//                   leading: Image.network(
//                     'https://picsum.photos/id/${post.id}/60',
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(post.title),
//                   subtitle: Text(post.body),
//                 );
//               },
//             ),
//           );
//         }
//       }),
//     );
//   }
// }
