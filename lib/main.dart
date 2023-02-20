import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/note.dart';
import 'db/note_repository.dart';
import 'note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  final notesBox = await Hive.openBox<Note>('notes');
  final noteRepository = NotesRepository(notesBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes App',
      home: NoteScreen(),
    );
  }
}
