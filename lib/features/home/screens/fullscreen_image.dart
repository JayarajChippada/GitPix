import 'package:flutter/material.dart';
import 'package:gitpix/models/bookmark_model.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageScreen extends StatelessWidget {
  static const String routeName = '/full-screen-image-screen';
  final String imageUrl;
  final String slug;

  const FullScreenImageScreen(
      {super.key, required this.imageUrl, required this.slug});

  @override
  Widget build(BuildContext context) {
    final bookmarkModel = Provider.of<BookmarkModel>(context);
    final isBookmarked = bookmarkModel.isBookmarked(imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text(slug),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: () {
              bookmarkModel.toggleBookmark(imageUrl);
            },
          ),
        ],
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
