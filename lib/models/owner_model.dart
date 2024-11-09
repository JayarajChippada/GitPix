// OwnerAccount Model
class OwnerAccount {
  final String login;
  final int id;
  final String avatarUrl;
  final String url;
  final String htmlUrl;
  final String type;
  final String company;
  final String blog;
  final String location;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final DateTime createdAt;
  final DateTime updatedAt;

  OwnerAccount({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
    required this.type,
    required this.company,
    required this.blog,
    required this.location,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OwnerAccount.fromJson(Map<String, dynamic> json) {
    return OwnerAccount(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
      htmlUrl: json['html_url'],
      type: json['type'],
      company: json['company'] ?? '',
      blog: json['blog'] ?? '',
      location: json['location'] ?? '',
      publicRepos: json['public_repos'],
      publicGists: json['public_gists'],
      followers: json['followers'],
      following: json['following'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
