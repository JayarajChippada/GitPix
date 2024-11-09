import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gitpix/features/home/screens/fullscreen_image.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'dart:async';

class GalleryTab extends StatefulWidget {
  const GalleryTab({super.key});

  @override
  _GalleryTabState createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  List<dynamic> images = [];
  final String cacheKey = 'galleryImages';
  final accessKey = dotenv.env['UNSPLASH_ACCESS_KEY'];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(cacheKey);

    if (fileInfo != null) {
      final cachedData = await fileInfo.file.readAsString();
      setState(() {
        images = json.decode(cachedData);
      });
    }

    fetchImagesAndUpdateCache();
  }

  Future<void> fetchImagesAndUpdateCache() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.unsplash.com/photos?client_id=$accessKey'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> fetchedImages = json.decode(response.body);
        setState(() {
          images = fetchedImages;
        });

        final cacheManager = DefaultCacheManager();
        await cacheManager.putFile(
          cacheKey,
          response.bodyBytes,
          fileExtension: 'json',
        );
      } else {
        throw Exception('Failed to load images');
      }
    } catch (error) {
      print('Error fetching images: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: images.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        FullScreenImageScreen.routeName,
                        arguments: {
                          'imageUrl': images[index]['urls']['regular'],
                            'slug': images[index]['slug'],
                        }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: images[index]['urls']['small'],
                          placeholder: (context, url) => Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
