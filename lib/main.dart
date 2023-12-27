import 'package:daily_expense/pages/add_expense_page.dart';
import 'package:daily_expense/pages/category_page.dart';
import 'package:daily_expense/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: ()=> const HomePage()),
        GetPage(name: '/addExpense', page: ()=> const AddExpensePage()),
        GetPage(name: '/category', page: ()=> const AddCategoryPage()),
      ],
    );
  }
}

