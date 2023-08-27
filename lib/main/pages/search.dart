import 'dart:async';

import 'package:flutter/material.dart';
import 'package:y/main/pages/profile.dart';
import 'package:y/utils/route.dart';

import '../models/user.dart';
import '../repo/user_repo.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  Timer? _debounce;
  List<User> _searchResults = [];
  bool _isLoading = false;

  void _onSearchChanged(String query, BuildContext context) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(query, context);
    });
  }

  void _search(String query, BuildContext context) {
    setState(() {
      _isLoading = true;
    });

    UserRepo.search(query).then((users) {
      setState(() {
        _searchResults = users;
        _isLoading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }

  Widget _buildResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 99, 99, 99),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
            radius: 30,
          ),
          title: Text(user.name),
          subtitle: Text('@${user.username}'),
          onTap: () {
            Navigator.of(context).push(
              YPageRoute(
                page: ProfilePage(
                  user: user,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _searchFocusNode.requestFocus();
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        title: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
              ),
              controller: _searchController,
              focusNode: _searchFocusNode,
              autocorrect: false,
              onChanged: (query) => _onSearchChanged(query, context),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildResults(),
    );
  }
}
