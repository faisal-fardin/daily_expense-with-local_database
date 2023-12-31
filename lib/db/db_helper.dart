import 'package:daily_expense/models/category_models.dart';
import 'package:daily_expense/models/expense_models.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbHelper{

  final String crateTableCategory = '''create table $tblCategory(
  $tblCategoryColID integer primary key autoincrement,
  $tblCategoryColName text)''';

  final String createTableExpense = '''create table $tblExpense(
    $tblExpenseColId integer primary key autoincrement,
    $tblExpenseColName text,
    $tblExpenseColCategory text,
    $tblExpenseColAmount integer,
    $tblExpenseColFormattedDate text,
    $tblExpenseColTimeStamp integer,
    $tblExpenseColDay integer,
    $tblExpenseColMonth integer,
    $tblExpenseColYear integer)''';


  Future<Database> _open() async{
    final root = await getDatabasesPath();
    final dbPath = path.join(root,'expense.db');
    return openDatabase(dbPath, version: 1, onCreate: (db,version) async {
       await db.execute(crateTableCategory);
       await db.execute(createTableExpense);
    },);
  }

  Future<int> insertCategory(CategoryModels models) async{
    final db = await _open();
    return db.insert(tblCategory, models.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertExpense(ExpenseModels expense) async{
    final db = await _open();
    return db.insert(tblExpense, expense.toMap());
  }


  Future<int> updateExpense(ExpenseModels expense) async{
    final db = await _open();
    return db.update(tblExpense, expense.toMap(),where: '$tblExpenseColId = ?' ,whereArgs: [expense.id]);
  }



  Future<List<CategoryModels>> getAllCategories() async{
    final db = await _open();
    final List<Map<String,dynamic>> mapList = await db.query(tblCategory,orderBy: tblCategoryColName);
    return List.generate(mapList.length, (index) => CategoryModels.fromMap(mapList[index]));
  }

  Future<List<ExpenseModels>> getAllExpenses() async{
    final db = await _open();
    final List<Map<String,dynamic>> mapList = await db.query(tblExpense);
    return List.generate(mapList.length, (index) => ExpenseModels.fromMap(mapList[index]));
  }

  Future<List<ExpenseModels>> getAllExpensesByCategoryName(String name) async{
    final db = await _open();
    final List<Map<String,dynamic>> mapList = await db.query(tblExpense,where: '$tblExpenseColCategory = ? ', whereArgs: [name]);
    return List.generate(mapList.length, (index) => ExpenseModels.fromMap(mapList[index]));
  }

  Future<CategoryModels> getCategoryByName(String name) async{
    final db = await _open();
    final mapList = await db.query(tblCategory,where: '$tblCategoryColName = ? ', whereArgs: [name]);
    return CategoryModels.fromMap(mapList.first);
  }

  Future<int> deleteExpenseById(int id) async{
    final db = await _open();
    return db.delete(tblExpense, where: '$tblExpenseColId = ? ', whereArgs: [id]);
  }



}