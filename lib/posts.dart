import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'post_detail.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder<List<Post>>(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data != null) {
            List<Post> posts = snapshot.data!;
            return ListView(
              children: posts.map(
                (Post post) => Card(
                  elevation: 4.0, // Adds shadow effect to the card
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margin between cards
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners for the card
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0), // Padding inside the card
                    leading: Icon(Icons.album), // Fixed incorrect Icon usage
                    title: Text(
                      post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0, // Larger font for the title
                      ),
                    ),
                    subtitle: Text(
                      post.body,
                      maxLines: 2, // Limit lines for cleaner UI
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: post),
                      ),
                    ),
                  ),
                ),
              ).toList(),
            );
          } else {
            return Center(child: Text("No posts available"));
          }
        },
      ),
    );
  }
}
