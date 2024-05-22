import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/data/local/entity/base_entity.dart';
import 'package:task_manager/data/local/utils/constants.dart';

const String _dbName = 'todo.db';

abstract class DatabaseManager<T extends BaseEntity> with LocalConstants {
  static Database? _database;

  abstract String tableName;

  Database? get instance => _database;

  Future<void> createTable(Batch batch);

  static Future<void> initiateDatabase(List<DatabaseManager> tables) async {
    if (_database != null) {
      return;
    }

    try {
      _database = await openDatabase(
        join(await getDatabasesPath(), _dbName),
        version: 1,
        onCreate: (db, version) async {
          var batch = db.batch();
          for (var table in tables) {
            await table.createTable(batch);
          }
          await batch.commit();
        },
      );
    } catch (error) {
      print(error);
    }
  }

  Future<int> insert(T item) async => await _database!.insert(
        tableName,
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  Future<int> update(T item) async => await _database!
      .update(tableName, item.toMap(), where: 'id = ?', whereArgs: [item.id]);

  Future<int> delete(int ids) async =>
      await _database!.delete(tableName, where: 'id = ?', whereArgs: [ids]);

  Future<List<Map<String, dynamic>>> getEventTableData() async =>
      _database!.query(tableName);

  Future<List<Map<String, dynamic>>> query({
    required String where,
    required List<Object> whereArgs,
    List<String>? columns,
  }) async {
    return _database!.query(
      tableName,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<Map<String, dynamic>>> queryById(int id) async {
    return _database!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
