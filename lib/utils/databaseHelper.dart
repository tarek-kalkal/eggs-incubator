import 'package:eggsincubator/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String userTable = 'note_table';
//	String colId = 'id';
	String colPhone = 'phoneNbr';
	String colName = 'name';
//String colPriority = 'priority';
//String colDate = 'password';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'users.db';

		// Open/create the database at a given path
		var userDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return userDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $userTable($colPhone TEXT, '
				'$colName TEXT)');
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getuserMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $userTable order by $colPriority ASC');
	/* 	var result = await db.query(userTable, orderBy: '$colPriority ASC');
		return result; */
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertUser(User user) async {
		Database db = await this.database;
		var result = await db.insert(userTable, user.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> updateUser(User user) async {
		var db = await this.database;
		var result = await db.update(userTable, user.toMap(), where: '$colPhone = ?', whereArgs: [user.phonenbr]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteUser(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $userTable WHERE $colPhone = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $userTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<User>> getNoteList() async {

		var userMapList = await getuserMapList(); // Get 'Map List' from database
		int count = userMapList.length;         // Count the number of map entries in db table

		List<User> userList = List<User>();
		// For loop to create a 'User List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			userList.add(User.fromMapObject(userMapList[i]));
		}

		return userList;
	}
}