import 'package:flutter/material.dart';
import 'package:gitpix/features/home/screens/bookmark_screen.dart';
import 'package:gitpix/features/home/screens/file_detail_screen.dart';
import 'package:gitpix/features/home/screens/file_list_screen.dart';
import 'package:gitpix/features/home/screens/fullscreen_image.dart';
import 'package:gitpix/features/home/screens/home_screen.dart';
import 'package:gitpix/models/gist_model.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );

    case BookmarkScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const BookmarkScreen(),
      );

    case FileListScreen.routeName:
      var files = routeSettings.arguments as List<GistFile>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => FileListScreen(
          files: files,
        ),
      );

    case FileDetailScreen.routeName:
      var file = routeSettings.arguments as GistFile;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => FileDetailScreen(
          file: file,
        ),
      );

    case FullScreenImageScreen.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      var imageUrl = args['imageUrl']!;
      var slug = args['slug']!;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => FullScreenImageScreen(
          imageUrl: imageUrl,
          slug: slug,
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}
