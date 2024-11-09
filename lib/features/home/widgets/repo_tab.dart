import 'package:flutter/material.dart';
import 'package:gitpix/features/home/screens/file_list_screen.dart';
import 'package:gitpix/features/home/services/home_services.dart';
import 'package:gitpix/models/gist_model.dart';

class RepoTab extends StatefulWidget {
  const RepoTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RepoTabState createState() => _RepoTabState();
}

class _RepoTabState extends State<RepoTab> {
  final HomeServices _homeServices = HomeServices();
  List<Gist> _gists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGists();
  }

  Future<void> _fetchGists() async {
    try {
      final gists = await _homeServices.fetchGists(context);
      setState(() {
        _gists = gists;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Error is already handled in service
    }
  }

  Future<void> _showOwnerInfo(BuildContext context, String ownerUrl) async {
    final owner = await _homeServices.fetchOwnerAccount(context, ownerUrl);

    if (owner != null) {
      // ignore: use_build_context_synchronously
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  // ignore: unnecessary_null_comparison
                  backgroundImage: owner.avatarUrl != null
                      ? NetworkImage(owner.avatarUrl)
                      : null,
                  radius: 20,
                  // ignore: unnecessary_null_comparison
                  child: owner.avatarUrl == null
                      ? const Icon(Icons.person, size: 20)
                      : null,
                ),
                const SizedBox(width: 10),
                Text(owner.login, style: const TextStyle(fontSize: 20)),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInfoRow(Icons.link, "GitHub URL", owner.htmlUrl),
                  _buildInfoRow(Icons.work, "Company", owner.company),
                  _buildInfoRow(Icons.web, "Blog", owner.blog),
                  _buildInfoRow(Icons.location_on, "Location", owner.location),
                  _buildInfoRow(Icons.storage, "Public Repos",
                      owner.publicRepos.toString()),
                  _buildInfoRow(
                      Icons.code, "Public Gists", owner.publicGists.toString()),
                  _buildInfoRow(
                      Icons.group, "Followers", owner.followers.toString()),
                  _buildInfoRow(Icons.person_add, "Following",
                      owner.following.toString()),
                  const Divider(),
                  Text(
                    'Joined on: ${_formatDate(owner.createdAt)}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Last updated: ${_formatDate(owner.updatedAt)}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return value != null && value.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(icon, size: 18, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$label: $value',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void _openFileList(BuildContext context, Gist gist) {
    Navigator.pushNamed(
      context,
      FileListScreen.routeName,
      arguments: gist.files
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: _gists.length,
              itemBuilder: (context, index) {
                final gist = _gists[index];
                final owner = gist.userUrl;

                return GestureDetector(
                  onTap: () => _openFileList(context, gist),
                  onLongPress: () => _showOwnerInfo(context, owner),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gist.description.isEmpty
                                ? "Gist Description"
                                : gist.description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.comment,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('${gist.comments}'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text('Created: ${_formatDate(gist.createdAt)}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Updated: ${_formatDate(gist.updatedAt)}'),
                              IconButton(
                                icon: const Icon(Icons.person),
                                onPressed: () => _showOwnerInfo(context, owner),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
