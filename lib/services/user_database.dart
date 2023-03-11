import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ropstem_task/models/model.dart';
import 'package:ropstem_task/utils/other.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class UserDatabase {
  final store = intMapStoreFactory.store('users');

  ///Init
  Future<Database> _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = appDocumentDir.path;
    final db = await databaseFactoryIo.openDatabase(join(dbPath, 'user_database.db'));

    return db;
  }

  ///Register
  Future<bool> registerUser(UserModel userModel) async {
    final db = await _openDatabase();
    final finder = Finder(filter: Filter.equals('user_email', userModel.email));
    final userList = await store.find(db, finder: finder);
    final user = userList.map((json) => UserModel.fromJson(json.value)).toList();
    if (user.isNotEmpty) {
      debugPrint('User Already Registered');
      UtilOther.showToast('User already registered');
      return false;
    } else {
      await store.add(db, userModel.toJson());
      UtilOther.showToast('User created');
      await db.close();
      return true;
    }
  }

  ///Login
  Future<UserModel?> loginUser(String email, String password) async {
    final db = await _openDatabase();
    final finder = Finder(filter: Filter.equals('user_email', email));
    final userList = await store.findFirst(db, finder: finder);
    // try {
    if (userList == null) {
      UtilOther.showToast('User not found');
      return null;
    } else {
      final user = UserModel.fromJson(userList.value);
      if (user.isLoggedIn) {
        return user;
      } else {
        if (user.password != password) {
          return null; // Incorrect password
        } else {
          final userNew = UserModel(
              id: user.id,
              name: user.name,
              email: user.email,
              password: user.password,
              isLoggedIn: true);
          updateUSer(userNew);
          return userNew;
        }
      }
    }
  }

  ///Update
  Future<void> updateUSer(UserModel userModel) async {
    final db = await _openDatabase();
    final finder = Finder(filter: Filter.equals('id', userModel.id));
    await store.update(
      db,
      userModel.toJson(),
      finder: finder,
    );
    await db.close();
  }

  ///Check is Logged in
  Future<bool> checkISLoggedIn() async {
    final db = await _openDatabase();
    final finder = Finder(filter: Filter.equals('isLoggedIn', true));
    var record = await store.findFirst(db, finder: finder);
    if (record == null) {
      return false;
    } else {
      return true;
    }
  }

  ///Logout
  Future<bool> logoutUser() async {
    final db = await _openDatabase();
    final finder = Finder(filter: Filter.equals('isLoggedIn', true));
    var record = await store.findFirst(db, finder: finder);
    if (record == null) {
      return false;
    } else {
      final userData = UserModel.fromJson(record.value);
      final newData = UserModel(
          id: userData.id,
          name: userData.name,
          email: userData.email,
          password: userData.password,
          isLoggedIn: false);
      updateUSer(newData);
      return true;
    }
  }
}
