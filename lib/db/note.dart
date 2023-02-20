import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late DateTime created_at;
  @HiveField(3)
  late DateTime updated_at;

  Note({
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
  });
}
