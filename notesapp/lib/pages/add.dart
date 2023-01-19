import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class addNewPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const addNewPage({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<addNewPage> createState() => _addNewPageState();
}

class _addNewPageState extends State<addNewPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note note = Note(
      id: const Uuid().v1(),
      userId: "tanmay",
      title: titleController.text,
      content: contentController.text,
      dateAdded: DateTime.now(),
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(note);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateAdded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                //update
                updateNote();
              } else
                addNewNote();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: (widget.isUpdate == true) ? false : true,
                onSubmitted: (val) {
                  if (val != "") {
                    noteFocus.requestFocus();
                  }
                },
                style: const TextStyle(
                  fontSize: 30,
                ),
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  maxLines: null, //to keep adding lines
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Note",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
