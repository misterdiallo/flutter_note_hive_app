import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/note.dart';
import 'db/note_repository.dart';

class CreateUpdateNoteScreen extends StatefulWidget {
  Note? noteToEdit;
  int? indexToEdit;
  CreateUpdateNoteScreen({
    Key? key,
    this.noteToEdit,
    this.indexToEdit,
  }) : super(key: key);

  @override
  State<CreateUpdateNoteScreen> createState() => _CreateUpdateNoteScreenState();
}

class _CreateUpdateNoteScreenState extends State<CreateUpdateNoteScreen> {
  late final NotesRepository _notesRepository;
  late final Box<Note> _notesBox;

  @override
  void initState() {
    super.initState();
    _notesRepository = NotesRepository(Hive.box<Note>('notes'));
    _notesBox = Hive.box<Note>('notes');
  }

  @override
  Widget build(BuildContext context) {
    final noteBox = Hive.box<Note>('notes');
    String title = '';
    String content = '';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteToEdit != null
            ? "Do some changes..."
            : "Something to keep.."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(builder: (
          context,
        ) {
          if (widget.noteToEdit != null && widget.indexToEdit != null) {
            title = widget.noteToEdit!.title;
            content = widget.noteToEdit!.content;
            return Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: TextEditingController(text: title),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  TextField(
                    controller: TextEditingController(text: content),
                    decoration: const InputDecoration(
                      labelText: 'Content',
                    ),
                    maxLines: 10,
                    onChanged: (value) {
                      content = value;
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (title.toString().isNotEmpty &&
                          content.toString().isNotEmpty) {
                        final updatedNote = Note(
                          title: title,
                          content: content,
                          created_at: widget.noteToEdit!.created_at,
                          updated_at: DateTime.now(),
                        );
                        await _notesRepository.updateNoteById(
                            widget.indexToEdit!, updatedNote);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            );
          }
          return Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(text: title),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  controller: TextEditingController(text: content),
                  decoration: const InputDecoration(
                    labelText: 'Content',
                  ),
                  maxLines: 10,
                  onChanged: (value) {
                    content = value;
                  },
                ),
                TextButton(
                  onPressed: () async {
                    if (title.toString().isNotEmpty &&
                        content.toString().isNotEmpty) {
                      final newNote = Note(
                        title: title,
                        content: content,
                        created_at: DateTime.now(),
                        updated_at: DateTime.now(),
                      );
                      await _notesRepository.addNote(newNote);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
