import 'package:daily_expense/custom_widgets/main_drawer.dart';
import 'package:daily_expense/pages/add_expense_page.dart';
import 'package:daily_expense/utils/widgets_funcation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../models/category_models.dart';
import '../provider/app_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  CategoryModels? categoryModel;
  @override
  void didChangeDependencies() {
    Provider.of<AppProvider>(context, listen: false).getAllExpenses();
    Provider.of<AppProvider>(context, listen: false).getAllCategories();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month),
            ),
          ],
          title: const Text('Home Page'),
          backgroundColor: Colors.black26,
        ),
        body: Consumer<AppProvider>(
          builder: (context, provider, child) => Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: Consumer<AppProvider>(
                      builder: (context, provider, child) =>
                          DropdownButtonFormField<CategoryModels>(
                            value: categoryModel,
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
                                categoryModel = value;
                              });
                              if(categoryModel!.name == 'All'){
                                provider.getAllExpenses();
                              }else{
                                provider.getAllExpensesByCategoryName(categoryModel!.name);
                              }

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

              Expanded(
                child: ListView.builder(
                    itemCount: provider.expenseList.length,
                    itemBuilder: (context, index) {
                      final expense = provider.expenseList[index];
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) {
                          return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Expense'),
                              content: Text(
                                  'Are you sure to delete item ${expense.name}?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('NO'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('NO'),
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (direction) async {
                          final deleteId = await provider.deleteExpense(expense.id!);
                          showMsg(context, 'Deleted');
                        },
                        background: Container(
                          padding: const EdgeInsets.only(right: 25),
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 5),
                          child: Container(
                              height: 80,
                              decoration: ShapeDecoration(
                                color: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: ListTile(
                                leading: IconButton(
                                  onPressed: () {
                                    Get.toNamed('/addExpense', arguments: expense);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                title: Text(
                                  expense.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  expense.formattedDate,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                trailing: Text(
                                  "BDT ${expense.amount}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(
              '/addExpense',
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
