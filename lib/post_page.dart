import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'controller/post_provider.dart';
import 'controller/video_player_controller.dart';

import 'package:video_player/video_player.dart';

class PostPage extends StatelessWidget {
  final String postId;

  const PostPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostProvider>(context).getPostById(postId);

    if (post.type == 'video') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<VideoPlayerProvider>(context, listen: false)
            .initializeVideo(post.content);
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (post.type == 'text')
            Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(post.content,
                  style: const TextStyle(color: Colors.black)),
            )),
          if (post.type == 'image') Image.asset(post.content),
          if (post.type == 'video')
            Consumer<VideoPlayerProvider>(
              builder: (context, videoProvider, child) {
                if (videoProvider.controller != null &&
                    videoProvider.controller!.value.isInitialized) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: VideoPlayer(videoProvider.controller!));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: ElevatedButton(
              onPressed: () {
                _sharePost(context, postId);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Share',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.send,
                    size: 16,
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _sharePost(BuildContext context, String postId) {
    String deepLinkUrl = 'https://deeplink-2379d.web.app/posts/$postId';
    Share.share('Check out this post: $deepLinkUrl');
  }
}
