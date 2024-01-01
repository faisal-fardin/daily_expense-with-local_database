import 'dart:math';

import 'package:daily_expense/models/category_models.dart';
import 'package:daily_expense/models/expense_models.dart';
import 'package:daily_expense/provider/app_provider.dart';
import 'package:daily_expense/utils/helper_funcation.dart';
import 'package:daily_expense/utils/widgets_funcation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpensePage extends StatefulWidget {
  static const String routeName = '/add_expense';

  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  CategoryModels? categoryModels;
  DateTime selectedDate = DateTime.now();
  ExpenseModels? expenseModel;

  @override
  void didChangeDependencies() {
    Provider.of<AppProvider>(context, listen: false).getAllCategories();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg != null) {
      expenseModel = arg as ExpenseModels;
      _nameController.text = expenseModel!.name;
      _amountController.text = expenseModel!.amount.toString();
      selectedDate =
          DateTime.fromMillisecondsSinceEpoch(expenseModel!.timeStamp);
      _getCategory(expenseModel!.name);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(expenseModel == null ? 'Add New Expense' : 'Update Expense'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: TextFormField(
                  controller: _nameController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Expense Name',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Provide an expense';
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Expense Amount',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Provide an Amount';
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    child: Consumer<AppProvider>(
                      builder: (context, provider, child) =>
                          DropdownButtonFormField<CategoryModels>(
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        value: categoryModels,
                        hint: const Text(
                          'Select Category',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        ),
                        isExpanded: true,
                        items: provider.categoryList
                            .map(
                              (e) => DropdownMenuItem<CategoryModels>(
                                enabled: e.name == "All" ? false : true,
                                value: e,
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                      color: e.name == "All"
                                          ? Colors.grey
                                          : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryModels = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select a category';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: _showDatePicker,
                    icon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.white,
                      ),
                    ),
                    label: const Text(
                      'Select Date',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: (){},
                    child: Text(getFormattedDate(selectedDate),style:const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              if (expenseModel == null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: saveExpense,
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              if (expenseModel != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: _updateExpense,
                    child: const Text('UPDATE'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void saveExpense() {
    if (_formKey.currentState!.validate()) {
      final expense = ExpenseModels(
        name: _nameController.text.trim(),
        categoryName: categoryModels!.name,
        amount: num.parse(_amountController.text.trim()),
        formattedDate: getFormattedDate(selectedDate),
        timeStamp: selectedDate.millisecondsSinceEpoch,
        day: selectedDate.day,
        month: selectedDate.month,
        year: selectedDate.year,
      );
      Provider.of<AppProvider>(context, listen: false)
          .addExpense(expense)
          .then((value) {
        showMsg(context, 'Save');
        Navigator.pop(context);
      }).catchError((error) {
        showMsg(context, 'Failed to Save');
      });
    }
  }

  void _getCategory(String name) async {
    categoryModels = await Provider.of<AppProvider>(context, listen: false)
        .getCategoryByName(expenseModel!.categoryName);
    setState(() {});
  }

  void _updateExpense() async {
    if (_formKey.currentState!.validate()) {
      expenseModel!.name = _nameController.text.trim();
      expenseModel!.categoryName = categoryModels!.name;
      expenseModel!.amount = num.parse(_amountController.text.trim());
      expenseModel!.formattedDate = getFormattedDate(selectedDate);
      expenseModel!.timeStamp = selectedDate.millisecondsSinceEpoch;
      expenseModel!.day = selectedDate.day;
      expenseModel!.month = selectedDate.month;
      expenseModel!.year = selectedDate.year;

      Provider.of<AppProvider>(context, listen: false)
          .updateExpense(expenseModel!)
          .then((value) {
        showMsg(context, 'Updated');
        Navigator.pop(context);
      }).catchError((error) {
        showMsg(context, 'Failed to Updated');
      });
    }
  }
}
