import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharingapp/post_page.dart';

import 'controller/post_provider.dart';

class HomePage extends StatefulWidget {
  final String? initialPostId;

  const HomePage({Key? key, this.initialPostId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? _postId;

  @override
  void initState() {
    super.initState();
    if (widget.initialPostId != null) {
      _postId = widget.initialPostId;
      _currentIndex = _getIndexFromPostId(
          _postId!); // Update bottom navigation index based on deep link
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          final posts = postProvider.posts;

          // If there's an initial postId from deep link, show corresponding post
          if (_postId != null) {
            final post = postProvider.getPostById(_postId!);
            return PostPage(postId: post.id);
          } else {
            // Normal flow, show post based on current index
            return PostPage(postId: posts[_currentIndex].id);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _postId = null; // Reset postId to use normal bottom navigation flow
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Text'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Image'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection), label: 'Video'),
        ],
      ),
    );
  }

  // This method determines the index for the bottom navigation based on the post type
  int _getIndexFromPostId(String postId) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    final post = postProvider.getPostById(postId);

    switch (post.type) {
      case 'text':
        return 0;
      case 'image':
        return 1;
      case 'video':
        return 2;
      default:
        return 0;
    }
  }
}
