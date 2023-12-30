
import 'package:daily_expense/db/db_helper.dart';
import 'package:daily_expense/models/category_models.dart';
import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {

  List<CategoryModels> categoryList =[];

  final db = DbHelper();
  Future<int> addCategory(String value) async{
    final category = CategoryModels(value);
    final id = await db.insertCategory(category);
    await getAllCategories();
    return id;
  }

  Future<void>getAllCategories() async{
    categoryList = await db.getAllCategories();
    notifyListeners();
  }


}