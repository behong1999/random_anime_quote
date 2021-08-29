import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/models.dart';

class MyDatabase {
  static Database? _db;
  static const String ID = 'id';
  static const String QUOTETEXT = 'quote_text';
  static const String QUOTECHARACTER = 'quote_character';
  static const String QUOTEANIME = 'quote_anime';
  static const String TABLE = 'quotes';
  static const String DB_NAME = 'favoriteQuotes.db';

  //* Check the db available or not and return the value
  Future<Database?> get fetchDatabase async {
    if (_db != null) {
      return _db;
    }
    _db = await _initializeDb();
    return _db;
  }

  //* Intialize the database, fetch the path and then open the database for the same
  _initializeDb() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    print(path);
    //* If [version] is specified, [onCreate], [onUpgrade], and [onDowngrade] can be called.
    //* [onCreate] is called if the database did not exist prior to calling [openDatabase].
    var db = await openDatabase(path, version: 1, onCreate: _createTable);
    return db;
  }

  //* Create my table if not available
  _createTable(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $QUOTETEXT TEXT, $QUOTECHARACTER TEXT, $QUOTEANIME TEXT)");
    print('Database Created');
  }

  //* Save the Quote once user clicked the button
  saveQuote(Quote quote) async {
    var dbClient = await fetchDatabase;
    await dbClient!.insert(TABLE, quote.toMap());
  }

  //* Close the connection to database
  Future closeDbConnection() async {
    var dbClient = await fetchDatabase;
    dbClient!.close();
  }

  //* Fetch the Saved Quotes from Table
  Future<List<Quote>> fetchSavedQuotes() async {
    var dbClient = await fetchDatabase;
    List<Map<String, dynamic>> maps = await dbClient!
        .query(TABLE, columns: [QUOTETEXT, QUOTECHARACTER, QUOTEANIME]);
    List<Quote> quotes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        quotes.add(Quote.fromMap(maps[i]));
      }
    }
    return quotes;
  }

  //* Delete
  Future<int> deleteQuoteFromFavorite(String quote) async {
    var dbClient = await fetchDatabase;
    return await dbClient!
        .delete(TABLE, where: '$QUOTETEXT = ?', whereArgs: [quote]);
  }

  Future<int> check(String? quote) async {
    var dbClient = await fetchDatabase;
    List<Map> list = await dbClient!.query(TABLE,
        columns: ['$QUOTETEXT'], where: '$QUOTETEXT = ?', whereArgs: [quote]);
    return list.length;
  }
}
