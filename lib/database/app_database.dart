import 'package:apps_architecture/database/dao/post_dao.dart';
import 'package:apps_architecture/database/entities/post_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart';

@Database(version: 1, entities: [PostEntity])
abstract class AppDatabase extends FloorDatabase {
  PostDao get postDao;
}
