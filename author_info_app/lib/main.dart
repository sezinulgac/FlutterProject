import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'author_cubit.dart';
import 'author_works_screen.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Author Info App',
      home: BlocProvider(
        create: (context) => AuthorCubit(),
        child: AuthorInfoScreen(),
      ),
    );
  }
}

class AuthorInfoScreen extends StatefulWidget {
  @override
  _AuthorInfoScreenState createState() => _AuthorInfoScreenState();
}

class _AuthorInfoScreenState extends State<AuthorInfoScreen> {
  final TextEditingController _authorNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author Info App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _authorNameController,
              decoration: InputDecoration(labelText: 'Enter Author Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final authorName = _authorNameController.text;
                context.read<AuthorCubit>().getAuthorInfo(authorName);
              },
              child: Text('Get Author Info'),
            ),
            SizedBox(height: 32),
            BlocBuilder<AuthorCubit, AuthorState>(
              builder: (context, state) {
                if (state is AuthorLoading) {
                  return CircularProgressIndicator();
                } else if (state is AuthorLoaded) {
                  final authorInfo = state.authorInfo;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Author Name: ${authorInfo['name'] ?? 'N/A'}'),
                      Text('Birth Date: ${authorInfo['dates'] ?? 'N/A'}'),
                      Text('Most Important Work: ${authorInfo['mostImportantWork'] ?? 'N/A'}'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final authorKey = authorInfo['key'];
                          if (authorKey != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthorWorksScreen(authorKey: authorKey),
                              ),
                            );
                          } else {
                            print('Author key is null');
                          }
                        },
                        child: Text('View Author Works'),
                      ),
                    ],
                  );
                } else if (state is AuthorError) {
                  return Text('Error: ${state.errorMessage}');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
