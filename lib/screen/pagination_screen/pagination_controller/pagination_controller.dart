import 'package:asif/screen/pagination_screen/model/post_model.dart';
import 'package:asif/screen/pagination_screen/repository/post_repository.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  final  _postService = PostRepository();

  List<PostModel> _posts =  [];

  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _limit = 20; // Adjust the limit as needed

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchPosts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      List<PostModel> newPosts = await _postService.fetchPosts(_page, _limit);
      if (newPosts.isEmpty) {
        _hasMore = false; // No more posts to load
      } else {
        _posts.addAll(newPosts);
        _page++; // Increment the page for the next fetch
      }
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
