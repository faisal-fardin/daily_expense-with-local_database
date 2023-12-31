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

  @override
  void didChangeDependencies() {
    Provider.of<AppProvider>(context, listen: false).getAllCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
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
                        horizontal: 10.0, vertical: 20),
                    child: Consumer<AppProvider>(
                      builder: (context, provider, child) =>
                          DropdownButtonFormField<CategoryModels>(
                        value: categoryModels,
                        hint: const Text('Select Category'),
                        isExpanded: true,
                        items: provider.categoryList
                            .map(
                              (e) => DropdownMenuItem<CategoryModels>(
                                value: e,
                                child: Text(
                                  e.name,
                                  style: const TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: _showDatePicker,
                    icon: const Icon(Icons.calendar_month_sharp),
                    label: const Text('Select Date'),
                  ),
                  Text(getFormattedDate(selectedDate)),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: ElevatedButton(
                  onPressed: saveExpense,
                  child: const Text('SAVE'),
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
}
