// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PostDao? _postDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PostEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `body` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PostDao get postDao {
    return _postDaoInstance ??= _$PostDao(database, changeListener);
  }
}

class _$PostDao extends PostDao {
  _$PostDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _postEntityInsertionAdapter = InsertionAdapter(
            database,
            'PostEntity',
            (PostEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body
                }),
        _postEntityUpdateAdapter = UpdateAdapter(
            database,
            'PostEntity',
            ['id'],
            (PostEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body
                }),
        _postEntityDeletionAdapter = DeletionAdapter(
            database,
            'PostEntity',
            ['id'],
            (PostEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PostEntity> _postEntityInsertionAdapter;

  final UpdateAdapter<PostEntity> _postEntityUpdateAdapter;

  final DeletionAdapter<PostEntity> _postEntityDeletionAdapter;

  @override
  Future<List<PostEntity>> fetchAllPosts() async {
    return _queryAdapter.queryList('Select * from PostEntity',
        mapper: (Map<String, Object?> row) => PostEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            body: row['body'] as String));
  }

  @override
  Future<PostEntity?> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM users WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PostEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            body: row['body'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertUser(PostEntity post) async {
    await _postEntityInsertionAdapter.insert(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(PostEntity post) async {
    await _postEntityUpdateAdapter.update(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(PostEntity post) async {
    await _postEntityDeletionAdapter.delete(post);
  }
}
