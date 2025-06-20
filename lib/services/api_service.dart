import 'package:dio/dio.dart';
import 'package:test_fox/model/post_model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Posts>> fetchPosts() async {
    try {
      final response =
          await dio.get("https://jsonplaceholder.typicode.com/posts",
              options: Options(headers: {
                'Accept': 'application/json',
              }));

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Posts.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load : ${response.statusCode}');
      }
    } catch (e) {
      print("Error fatch Posts $e");
      throw Exception('Failed to load Posts');
    }
  }
}
