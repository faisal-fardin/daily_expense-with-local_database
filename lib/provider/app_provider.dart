
import 'package:daily_expense/db/db_helper.dart';
import 'package:daily_expense/models/category_models.dart';
import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {

  final db = DbHelper();
  Future<int> addCategory(String value) async{
    final category = CategoryModels(value);
    return db.insertCategory(category);
  }

}