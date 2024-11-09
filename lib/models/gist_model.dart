// Gist Model
class Gist {
  final String id;
  final String url;
  final List<GistFile> files;
  final String description;
  final int comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userUrl;

  Gist({
    required this.id,
    required this.url,
    required this.files,
    required this.description,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.userUrl,
  });

  factory Gist.fromJson(Map<String, dynamic> json) {
    List<GistFile> files = (json['files'] as Map<String, dynamic>)
        .values
        .map((fileJson) => GistFile.fromJson(fileJson))
        .toList();

    return Gist(
      id: json['id'],
      url: json['url'],
      files: files,
      description: json['description'] ?? '',
      comments: json['comments'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userUrl: json['owner']['url'],
    );
  }
}

// GistFile Model
class GistFile {
  final String filename;
  final String type;
  final String language;
  final String rawUrl;
  final int size;

  GistFile({
    required this.filename,
    required this.type,
    required this.language,
    required this.rawUrl,
    required this.size,
  });

  factory GistFile.fromJson(Map<String, dynamic> json) {
    return GistFile(
      filename: json['filename'],
      type: json['type'],
      language: json['language'] ?? 'Unknown',
      rawUrl: json['raw_url'],
      size: json['size'],
    );
  }
}

