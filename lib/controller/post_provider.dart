import 'package:flutter/material.dart';

class Post {
  final String id;
  final String type; // 'text', 'image', or 'video'
  final String content;

  Post({required this.id, required this.type, required this.content});
}

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [
    Post(id: '1', type: 'text', content: '“You ve gotta dance like theres nobody watching Love like you ll never be hurt, Sing like there s nobody listening,And live like it s heaven on earth.”'),
    Post(id: '2', type: 'image', content: 'assets/ifl.jpg'),
    Post(id: '3', type: 'video', content: 'assets/video.mp4'),
  ];

  List<Post> get posts => _posts;

  Post getPostById(String id) {
    return _posts.firstWhere((post) => post.id == id);
  }
}
