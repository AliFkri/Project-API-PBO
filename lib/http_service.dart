import 'dart:convert';
import 'package:http/http.dart' as http; // Alias http for clarity
import 'post_model.dart'; // Ensure that Post class is correctly imported

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> getPosts() async {
    try {
      // Sending GET request to the URL
      final response = await http.get(Uri.parse(postsURL));

      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Decode the response body into a list of dynamic objects
        List<dynamic> body = jsonDecode(response.body);

        // Map the dynamic objects into a list of Post objects
        List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();

        return posts;
      } else {
        // If status code isn't 200, throw an exception
        throw Exception("Failed to load posts. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Catching any errors, including network or parsing errors
      throw Exception("Error fetching posts: $e");
    }
  }
}
