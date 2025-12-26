import 'package:hive_flutter/adapters.dart';
import 'package:hive_notes/models/notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}
