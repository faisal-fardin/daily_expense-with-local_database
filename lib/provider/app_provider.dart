
import 'package:daily_expense/models/category_models.dart';
import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {

  Future<void> addCategory(String value){
    final category = CategoryModels(value);
  }

}