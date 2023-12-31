
import 'package:daily_expense/custom_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context,listen: false).getAllExpenses();
    return SafeArea(
      child: Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: Colors.black26,
        ),
        body: Consumer<AppProvider>(
          builder: (context, provider, child) =>  ListView.builder(
            itemCount: provider.expenseList.length,
            itemBuilder: (context, index) {
              final expense = provider.expenseList[index];
              return ListTile(
                title: Text(expense.name,style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed('/addExpense');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
