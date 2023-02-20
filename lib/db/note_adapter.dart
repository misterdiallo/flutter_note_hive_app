import 'package:hive/hive.dart';

import 'note.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    final numberOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numberOfFields; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }
    return Note(
      title: fields[0] as String,
      content: fields[1] as String,
      created_at: fields[1] as DateTime,
      updated_at: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Note note) {
    writer.writeByte(4);
    writer.writeByte(0);
    writer.write(note.title);
    writer.writeByte(1);
    writer.write(note.content);
    writer.writeByte(2);
    writer.write(note.created_at);
    writer.writeByte(3);
    writer.write(note.updated_at);
  }
}
