
import 'package:daily_expense/db/db_helper.dart';
import 'package:daily_expense/models/category_models.dart';
import 'package:daily_expense/models/expense_models.dart';
import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {

  List<CategoryModels> categoryList =[];
  List<ExpenseModels> expenseList =[];

  final db = DbHelper();


  Future<int> addCategory(String value) async{
    final category = CategoryModels(value);
    final id = await db.insertCategory(category);
    await getAllCategories();
    return id;
  }

  Future<int> addExpense(ExpenseModels expense) async{
    final id =  db.insertExpense(expense);
    await getAllExpenses();
    return id;
  }

  Future<int> updateExpense(ExpenseModels expense) async{
    final id = await db.updateExpense(expense);
    await getAllExpenses();
    return id;
  }



  Future<void>getAllCategories() async{
    categoryList = await db.getAllCategories();
    notifyListeners();
  }

  Future<void>getAllExpenses() async{
    expenseList = await db.getAllExpenses();
    notifyListeners();
  }

  Future<CategoryModels> getCategoryByName(String name) async {
    return db.getCategoryByName(name);
  }


  Future<int> deleteExpense(int id) async{
    final deleteRowId = await db.deleteExpenseById(id);
    await getAllExpenses();
    return deleteRowId;
  }





}