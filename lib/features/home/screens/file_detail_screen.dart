import 'package:flutter/material.dart';
import 'package:gitpix/models/gist_model.dart';

class FileDetailScreen extends StatelessWidget {
  static const String routeName = '/file-detail-screen';
  final GistFile file;

  const FileDetailScreen({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.filename),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File Header
            Text(
              "File Details",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Type: ${file.type}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Language: ${file.language}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Size: ${file.size} bytes',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Divider
            Divider(color: Colors.black38),

            // Scrollable Content Area
            Text(
              "File Content",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Content is not available!", // Assuming `content` is the file's text content
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'CourierNew', // A more file-like font
                      color: Colors.black87,
                      height: 1.5, // For better readability
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
