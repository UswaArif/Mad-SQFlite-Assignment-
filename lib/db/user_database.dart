import 'dart:async';
import 'package:crudoperations/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UserDatabase{
  //calling the constructor
  static final UserDatabase instance = UserDatabase._init();
  static late DatabaseFactory dbFactory;

  //getting fields from the database
  static Database? _database;
  //private constructor
  UserDatabase._init();

  //opening connection to the database
  Future<Database> get database async {
    if(_database != null)
    {
      return _database!;
    }
    else
    {
      dbFactory = databaseFactoryFfi;
      _database = await _initDB('users.db');
      return _database!;
    }
  }

  //intializing database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path  = join(dbPath,filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute(''' 
      CREATE TABLE $tableUsers (
        ${UserFields.id} $idType,
        ${UserFields.fullName} $textType,
        ${UserFields.phone} $integerType,
        ${UserFields.address} $textType,
        ${UserFields.email} $textType,
        ${UserFields.password} $textType,
        ${UserFields.role} $textType,
        ${UserFields.created_at} $textType,
        ${UserFields.updated_at} $textType,
        ${UserFields.active} $boolType
      )
    ''');
  }

  Future<UserModel> create(UserModel user) async {
    final db = await instance.database;
    final id  = await db.insert(tableUsers, user.toJson());
    print("data inserted");
    return user.copy(id: id);
  }

  Future<UserModel> readUser(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
    columns: UserFields.values,
    where: '${UserFields.id} = ?',
    whereArgs: [id],
    );
    if(maps.isNotEmpty)
    {
      return UserModel.fromJson(maps.first);
    }
    else
    {
      throw Exception('Id $id not found');
    }
  }

  Future<List<UserModel>> readAllUsers() async {
    final db = await instance.database;
    final orderBy = '${UserFields.id} ASC';
    final result = await db.query(tableUsers, orderBy: orderBy);
    return result.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<int> update(UserModel user) async {
    final db = await instance.database;
    return db.update(tableUsers, user.toJson(),
    where: '${UserFields.id} = ?',
    whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableUsers,
    where: '${UserFields.id} = ?',
    whereArgs: [id], 
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}