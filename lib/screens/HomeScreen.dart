import 'package:flutter/material.dart';

//import 'package:/flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider_notes/providers/NoteCollection.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var collection = NoteCollection()
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes')
      ),
    );
  }
}