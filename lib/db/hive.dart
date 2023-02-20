import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'note_adapter.dart';

Future<void> main() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(NoteAdapter());
}
