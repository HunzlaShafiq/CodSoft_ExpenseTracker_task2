import 'package:task1_expense_tracker/models/Expense_item.dart';
import 'package:hive/hive.dart';

class HiveDataBase
{
  // reference to our box

  final _myBox = Hive.box('expense_database');

  // store data to hive database
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allFormattedData =[];

    for(var expense in allExpense)
      {
        List<dynamic> formattedList=[
          expense.name,
          expense.amount,
          expense.dateTime
        ];

        allFormattedData.add(formattedList);
      }

    _myBox.put("ExpenseDataBase", allFormattedData);

  }

  // read data from hive database
  List<ExpenseItem> readData()
  {
    List savedExpense = _myBox.get("ExpenseDataBase")??[];
    List<ExpenseItem> allData =[];

    for(int i=0; i<savedExpense.length; i++)
      {
        String name= savedExpense[i][0];
        String amount = savedExpense[i][1];
        DateTime dateTime = savedExpense[i][2];

        ExpenseItem expenseItem =ExpenseItem(
          name: name,
          amount: amount,
          dateTime: dateTime
        );

        allData.add(expenseItem);
      }

    return allData;

  }

}
