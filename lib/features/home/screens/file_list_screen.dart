import 'package:flutter/material.dart';
import 'package:gitpix/features/home/screens/file_detail_screen.dart';
import 'package:gitpix/models/gist_model.dart';

class FileListScreen extends StatelessWidget {
  static const String routeName = '/file-list-screen';
  final List<GistFile> files;

  const FileListScreen({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Files'),
      ),
      body: files.isEmpty
          ? const Center(child: Text("No files available"))
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(file.filename),
                    subtitle: Text(file.type),
                    trailing:
                        const Icon(Icons.file_copy, color: Colors.blueAccent),
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        FileDetailScreen.routeName,
                        arguments: file 
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
