import 'package:asif/screen/pagination_screen/pagination_controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  late PostProvider postProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postProvider = PostProvider();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Posts with Pagination')),
      body: ChangeNotifierProvider(
        create: (_) => postProvider..fetchPosts(),
        child: Consumer<PostProvider>(
          builder: (context, postProvider, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !postProvider.isLoading) {
                  postProvider.fetchPosts();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: postProvider.posts.length + (postProvider.hasMore ? 1 : 0), // Show loading indicator if there are more posts
                itemBuilder: (context, index) {
                  if (index == postProvider.posts.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final post = postProvider.posts[index];
                  return Card(
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
