class Note
{
  String id;
  String body;

  static const String DEFAULT_NAME = 'New Note';

  Note({ this.id, this.body = '' });

  String get noteBody {
    return this.body.isNotEmpty ? this.body : Note.DEFAULT_NAME;
  }
}