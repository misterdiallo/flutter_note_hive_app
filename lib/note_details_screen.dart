import 'package:flutter/material.dart';
import 'package:flutter_note_hive/utils/convert_datetime.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'create_update_screen.dart';
import 'db/note.dart';

class NoteDetailScreen extends StatelessWidget {
  final int noteIndex;

  const NoteDetailScreen({Key? key, required this.noteIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteBox = Hive.box<Note>('notes');

    return ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box<Note> box, _) {
          final note = noteBox.getAt(noteIndex);
          return Scaffold(
            appBar: AppBar(
              title: Text(note!.title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => CreateUpdateNoteScreen(
                        noteToEdit: note,
                        indexToEdit: noteIndex,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Last update: ${ConvertDateTime.convertDate(note.updated_at)}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    note.content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
