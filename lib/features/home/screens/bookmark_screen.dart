import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gitpix/features/home/screens/fullscreen_image.dart';
import 'package:gitpix/models/bookmark_model.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookmarkScreen extends StatelessWidget {
  static const String routeName = '/bookmark-screen';
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkedImages =
        Provider.of<BookmarkModel>(context).bookmarkedImages.toList();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Bookmarks',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: bookmarkedImages.isEmpty
          ? const Center(child: Text('No bookmarks added'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                itemCount: bookmarkedImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        FullScreenImageScreen.routeName,
                        arguments: {
                          'imageUrl': bookmarkedImages[index],
                          'slug': 'Bookmarked Image ${index + 1}'
                        }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: bookmarkedImages[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
