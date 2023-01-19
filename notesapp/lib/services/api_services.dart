import 'dart:convert';
import 'dart:developer';

import 'package:notesapp/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "https://notes-app-mfef.onrender.com/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + '/add');
    var response = await http.post(requestUri, body: note.toMap());
    var encodeFirst = json.encode(response.body);
    var decoded = json.decode(encodeFirst);
    log(decoded.toString());
    //log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + '/delete');
    var response = await http.post(requestUri, body: note.toMap());
    var encodeFirst = json.encode(response.body);
    var decoded = json.decode(encodeFirst);
    log(decoded.toString());
    //log(decoded.toString());
  }

  static Future<List<Note>> fetchNote(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + '/list');
    var response = await http.post(requestUri, body: {"userid": userid});
    var encodeFirst = json.encode(response.body);
    var decoded = json.decode(encodeFirst);
    log(decoded.toString());

    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}
