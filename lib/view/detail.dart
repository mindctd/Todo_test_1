import 'package:flutter/material.dart';
import 'package:test_fox/model/post_model.dart';

class Detail extends StatelessWidget {
  final Posts posts;
  final String cleanBody;
  Detail({super.key, required this.posts})
      : cleanBody = posts.body.replaceAll("\n", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post id ${posts.id}"),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    child: Image.network(
                      "https://picsum.photos/id/${posts.id}/60",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          posts.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(cleanBody),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
