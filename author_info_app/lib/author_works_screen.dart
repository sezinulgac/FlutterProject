import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'author_service.dart';

class AuthorWorksScreen extends StatefulWidget {
  final String authorKey;

  AuthorWorksScreen({required this.authorKey});

  @override
  _AuthorWorksScreenState createState() => _AuthorWorksScreenState();
}

class _AuthorWorksScreenState extends State<AuthorWorksScreen> {
  final Dio _dio = Dio();
  late List<dynamic> works = [];

  @override
  void initState() {
    super.initState();
    _loadWorks();
  }

  Future<void> _loadWorks() async {
    try {
      final response = await AuthorService().getAuthorWorks(widget.authorKey);

      setState(() {
        works = response ?? [];
      });
    } catch (error) {
      print('Failed to load author works');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author Works'),
      ),
      body: works.isNotEmpty
          ? ListView.builder(
              itemCount: works.length,
              itemBuilder: (context, index) {
                final work = works[index];
                return ListTile(
                  title: Text(work['title'] ?? 'N/A'),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
