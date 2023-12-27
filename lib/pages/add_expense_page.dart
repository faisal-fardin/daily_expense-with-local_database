
import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  static const String routeName = '/add_expense';
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
      ),
    );
  }
}
