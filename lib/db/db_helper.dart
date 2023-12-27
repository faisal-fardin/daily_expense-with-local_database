import 'package:daily_expense/models/category_models.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbHelper{

  final String crateTableCategory = '''carte table $tblCategory(
  
  $tblCategoryColID integer primary key autoincrement,
  $tblCategoryColName text)''';


  Future<Database> _open() async{
    final root = await getDatabasesPath();
    final dbPath = path.join(root,'expense.db');
    return openDatabase(dbPath, version: 1, onCreate: (db,version) async {
       await db.execute(crateTableCategory);
    },);
  }

}