import 'package:flutter/material.dart';
import 'package:flutter_note_hive/create_update_screen.dart';
import 'package:flutter_note_hive/note_details_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/note.dart';
import 'db/note_repository.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late final NotesRepository _notesRepository;
  late final Box<Note> _notesBox;

  @override
  void initState() {
    super.initState();
    _notesRepository = NotesRepository(Hive.box<Note>('notes'));
    _notesBox = Hive.box<Note>('notes');
  }

  Future<void> _showDeleteNoteDialog(Note note, int id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure ?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You want to delete the nothe ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              note.title.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await _notesRepository.deleteNoteById(id);
              Navigator.pop(context);
            },
            child: const Text(
              'Yes, please',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes App'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _notesBox.listenable(),
        builder: (context, Box<Note> box, _) {
          final notes = box.values.toList();
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteNoteDialog(note, index),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => NoteDetailScreen(
                        noteIndex: index,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => CreateUpdateNoteScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
