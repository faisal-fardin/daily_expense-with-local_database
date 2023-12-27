import 'package:daily_expense/utils/widgets_funcation.dart';
import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  static const String routeName = '/category';

  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextFieldDialog(
            context: context,
            title: 'Add Category',
            hint: 'Enter Category Name',
            onSave: (value){

            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
