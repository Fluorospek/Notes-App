import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/provider/notes_provider.dart';
import 'add.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/pages/add.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true, //for title to be in the center
      ),
      body: SafeArea(
        child: (notesProvider.notes.length > 0)
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //number of container in a row
                ),
                itemCount: notesProvider
                    .notes.length, //number of containers in the grid
                itemBuilder: (context, index) {
                  //properties of the containers in the grid

                  Note currentNote = notesProvider.notes[index];

                  return GestureDetector(
                    onTap: () {
                      //update current note
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addNewPage(
                                  isUpdate: true, note: currentNote)));
                    },
                    onLongPress: () {
                      //delete current note
                      notesProvider.deleteNote(currentNote);
                    },
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notesProvider.notes[index].title!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              notesProvider.notes[index].content!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                  );
                },
              )
            : const Center(
                child: Text('No notes yet'),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const addNewPage(
                isUpdate: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
