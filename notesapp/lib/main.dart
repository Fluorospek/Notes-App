import 'package:flutter/material.dart';
import 'package:notesapp/pages/home_page.dart';
import 'package:notesapp/provider/notes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NotesProvider())],
      child: const MaterialApp(
        home: homepage(),
      ),
    );
  }
}
