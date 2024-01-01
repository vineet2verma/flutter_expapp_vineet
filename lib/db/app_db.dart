
import 'package:exp_app_vineet/models/expense_model.dart';
import 'package:exp_app_vineet/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  // private constructor
  AppDataBase._();

  static final AppDataBase instance = AppDataBase._();

  Database? myDB;

  // login pref Key
  static final String LOGIN_UID = "uid";

  //table
  static final String EXPENSE_TABLE = "expense";
  static final String USER_TABLE = "users";

  // Columns
  static final String COLUMN_USER_ID = "uId";
  static final String COLUMN_USER_NAME = "uName";
  static final String COLUMN_USER_EMAIL = "uEmail";
  static final String COLUMN_USER_PASS = "uPass";

  // Exp Column
  static final String COLUMN_EXPENSE_ID = "expId";
  static final String COLUMN_EXPENSE_TITLE = "expTitle";
  static final String COLUMN_EXPENSE_DESC = "expDesc";
  static final String COLUMN_EXPENSE_TIMESTAMP = "expTimeStamp";
  static final String COLUMN_EXPENSE_AMT = "expaMT";
  static final String COLUMN_EXPENSE_BALANCE = "expBal";
  static final String COLUMN_EXPENSE_TYPE = "expType";    // 0 for debit & 1 for credit
  static final String COLUMN_EXPENSE_CAT_TYPE = "expCatType";

  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(docDirectory.path, "expenso.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version){
      // create all db table
      // user table
      db.execute(
          "create table $USER_TABLE ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text, $COLUMN_USER_PASS text)");
      // expense table
      db.execute(
          "create table $EXPENSE_TABLE ($COLUMN_EXPENSE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_EXPENSE_TITLE text, $COLUMN_EXPENSE_DESC text, $COLUMN_EXPENSE_TIMESTAMP text, $COLUMN_EXPENSE_AMT real, $COLUMN_EXPENSE_BALANCE real, $COLUMN_EXPENSE_TYPE integer, $COLUMN_EXPENSE_CAT_TYPE integer)");
    });
  }

  Future<Database> getDB() async{
    if(myDB != null){
      return myDB!;
    } else{
      myDB = await initDB();
      return myDB!;
    }
  }

  Future<int> getUID() async {
    var pref = await SharedPreferences.getInstance();
    var uid = pref.getInt(LOGIN_UID);
    return uid ?? 0 ;
  }

  //Queries for User
  Future<bool> checkIfAreadyExists(String email) async {
    var db = await getDB();
    var data = await db
        .query(USER_TABLE, where: "$COLUMN_USER_EMAIL = ?", whereArgs: [email] );
    return data.isNotEmpty;
  }

  Future<bool> createAccount(UserModel newUser) async {
    var check = await checkIfAreadyExists(newUser.user_email);

    // !check => null check
    // check! => .toString()

    if(!check){
      var db = await getDB();
      db.insert(USER_TABLE,newUser.toMap());
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> authenticaterUser(String email, String pass) async {
    var db = await getDB();
    var data = await db
        .query(USER_TABLE, where: "$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?" , whereArgs: [email,pass]);
    return data.isNotEmpty;
  }

  Future<bool> addExpenses(ExpenseModel newExpense) async{
    var db = await getDB();
    int rowEffected = await db.insert(EXPENSE_TABLE,newExpense.toMap() );
    return rowEffected>0;
  }

  Future<void> deleteExpense(int id) async{
    var db= await getDB();
    await db.delete(EXPENSE_TABLE,
    where: "$COLUMN_EXPENSE_ID = ?", whereArgs: [id.toString()]);
  }

  Future<List<ExpenseModel>> fetchAllExpense() async{
    var db = await getDB();
    var data = await db.query(EXPENSE_TABLE, orderBy: "$COLUMN_EXPENSE_TIMESTAMP DESC");
    List<ExpenseModel> listexp = [];
    for(Map<String,dynamic> eachMap in data){
      listexp.add(ExpenseModel.fromMap(eachMap));
    }
    return listexp;
  }



}