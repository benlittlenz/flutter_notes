import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_notes/models/Note.dart';

import 'package:uuid/uuid.dart';

//import 'package:/flutter/widgets.dart';
//import 'package:flutter/material.dart';
import 'package:provider_notes/providers/NoteCollection.dart';
import 'package:provider_notes/screens/NoteScreen.dart';

class HomeScreen extends StatelessWidget {
  var uuid = Uuid();
  var collection = NoteCollection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Consumer<NoteCollection>(
        builder: (context, notes, child) {
          return Text('Notes (${notes.count})');
        },
      )),
      //body: _buildNotesList(),
      body: ListView(
        children: [
          Image.asset(
            'images/lake.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Note note = Note(
            id: uuid.v4(),
          );

          Provider.of<NoteCollection>(context, listen: false).addNote(note);

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NoteScreen(note: note)));
        },
      ),
    );
  }

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              )
            ],
          ),
        ),
        // Icon(
        //   Icons.star,
        //   color: Colors.red[500],
        // ),
        // Text('41')
        FavoriteWidget(),
      ],
    ),
  );

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
      'Alps. Situated 1,578 meters above sea level, it is one of the '
      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
      'half-hour walk through pastures and pine forest, leads you to the '
      'lake, which warms to 20 degrees Celsius in the summer. Activities '
      'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );

  Widget buttonSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
        _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
      ],
    ),
  );

  Widget _buildNotesList() {
    return Consumer<NoteCollection>(builder: (context, notes, child) {
      var allNotes = notes.allNotes;

      if (allNotes.length == 0) {
        return Center(
          child: Text('No Notes'),
        );
      }

      return ListView.builder(
          itemCount: notes.count,
          itemBuilder: (context, index) {
            var note = notes.allNotes[index];

            return Dismissible(
                key: Key(note.id),
                background: Container(
                    color: Colors.red,
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Text("Move to trash",
                                style: TextStyle(color: Colors.white))
                          ],
                        ))),
                confirmDismiss: (direction) async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("Delete Confirmation"),
                            content: const Text(
                                "Are you sure you want to delete this note?"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Delete")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("Cancel")),
                            ]);
                      });
                },
                onDismissed: (direction) {
                  Provider.of<NoteCollection>(context).deleteNote(note);
                },
                child: ListTile(
                    title: Text(note.body),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NoteScreen(note: note)));
                    }));
          });
    });
  }
}

Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: color),
        ),
      ),
    ],
  );
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _togleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }

  void _togleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = false;
      }
    });
  }
}
