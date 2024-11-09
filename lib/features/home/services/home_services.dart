import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gitpix/models/gist_model.dart';
import 'package:gitpix/models/owner_model.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  final String apiUrl = 'https://api.github.com/gists/public';

  // Fetches list of gists
  Future<List<Gist>> fetchGists(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Gist.fromJson(json)).toList();
      } else {
        _showError(context, 'Failed to load gists: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      _showError(context, e.toString());
      return [];
    }
  }

  // Fetches owner account details by URL, with optional caching
  final Map<String, OwnerAccount> _ownerCache = {};

  Future<OwnerAccount?> fetchOwnerAccount(
      BuildContext context, String ownerUrl) async {
    // Check cache first
    if (_ownerCache.containsKey(ownerUrl)) {
      return _ownerCache[ownerUrl];
    }
    try {
      final response = await http.get(Uri.parse(ownerUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final owner = OwnerAccount.fromJson(data);
        _ownerCache[ownerUrl] = owner; // Store in cache
        return owner;
      } else {
        _showError(
            context, 'Failed to load owner account: ${response.statusCode}');
      }
    } catch (e) {
      _showError(context, e.toString());
    }
    return null;
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
