import 'package:flutter/material.dart';

class BookmarkModel extends ChangeNotifier {
  final Set<String> _bookmarkedImages = {};

  Set<String> get bookmarkedImages => _bookmarkedImages;

  void toggleBookmark(String imageUrl) {
    if (_bookmarkedImages.contains(imageUrl)) {
      _bookmarkedImages.remove(imageUrl);
    } else {
      _bookmarkedImages.add(imageUrl);
    }
    notifyListeners();
  }

  bool isBookmarked(String imageUrl) => _bookmarkedImages.contains(imageUrl);
}
