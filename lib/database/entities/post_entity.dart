import 'package:floor/floor.dart';

@entity
class PostEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String body;

  PostEntity({this.id, required this.title, required this.body});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
