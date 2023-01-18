import 'package:flutter/cupertino.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;

  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  void sortNotes() {
    //taking two elements from the array
    notes.sort((x, y) => y.dateAdded!.compareTo(x.dateAdded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNote("tanmay");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
}
