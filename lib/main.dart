import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_notes/providers/NoteCollection.dart';
import 'package:provider_notes/screens/HomeScreen.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => new NoteCollection(),
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
