const String tblExpense = 'tbl_expense';
const String tblExpenseColId = 'id';
const String tblExpenseColName = 'name';
const String tblExpenseColCategory = 'category';
const String tblExpenseColAmount = 'amount';
const String tblExpenseColFormattedDate = 'date';
const String tblExpenseColTimeStamp = 'timestamp';
const String tblExpenseColDay = 'day';
const String tblExpenseColMonth = 'Month';
const String tblExpenseColYear = 'Year';

class ExpenseModels {
  int? id;
  String name;
  String categoryName;
  num amount;
  String formattedDate;
  int timeStamp;
  int day;
  int month;
  int year;

  ExpenseModels(
      {this.id,
      required this.name,
      required this.categoryName,
      required this.amount,
      required this.formattedDate,
      required this.timeStamp,
      required this.day,
      required this.month,
      required this.year});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblExpenseColName: name,
      tblExpenseColCategory: categoryName,
      tblExpenseColAmount: amount,
      tblExpenseColFormattedDate: formattedDate,
      tblExpenseColTimeStamp: timeStamp,
      tblExpenseColDay: day,
      tblExpenseColMonth: month,
      tblExpenseColYear: year,
    };
    if (id != null) {
      map[tblExpenseColId] = id;
    }
    return map;
  }
  factory ExpenseModels.fromMap(Map<String, dynamic> map) => ExpenseModels(
        id: map[tblExpenseColId],
        name: map[tblExpenseColName],
        categoryName: map[tblExpenseColCategory],
        amount: map[tblExpenseColAmount],
        formattedDate: map[tblExpenseColFormattedDate],
        timeStamp: map[tblExpenseColTimeStamp],
        day: map[tblExpenseColDay],
        month: map[tblExpenseColMonth],
        year: map[tblExpenseColYear],
      );
}
