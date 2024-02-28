import 'package:task1_expense_tracker/data/Hive_Database.dart';
import 'package:task1_expense_tracker/models/Expense_item.dart';
import 'package:flutter/cupertino.dart';
import '../DateConverter/Date_Convert_To_String.dart';

class ExpenseData extends ChangeNotifier {
  // List of all expense
  List <ExpenseItem>  overAllExpense =[];

  // get the Expense all list
  List<ExpenseItem>  getExpenseList () {
    return overAllExpense;
  }

  //prepare data to display from database
  final db= HiveDataBase();
  void prepareData()
  {
    if(db.readData().isNotEmpty)
      {
        overAllExpense= db.readData();
      }
  }


  //Add new item in Expense item

  void addNewItem (ExpenseItem newExpense) {
    overAllExpense.add(newExpense);
    notifyListeners();

    db.saveData(overAllExpense);
  }

  //Delete item from list

  void deleteItem (ExpenseItem expense) {
    overAllExpense.remove(expense);
    notifyListeners();

    db.saveData(overAllExpense);
  }

  // Get the name of day

  String getDayName (DateTime dateTime) {
    switch(dateTime.weekday)
        {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default :
        return'';
    }
  }

  //get the date for the start of week (sunday)

  DateTime? startOfDate () {
    DateTime? startOfDate;

    //get today date
    DateTime today = DateTime.now();

    // go back from today to sunday

    for(int i=0;i<7;i++)
      {
        if(getDayName(today.subtract(Duration(days: i)))=='Sun')
          {
            startOfDate = today.subtract(Duration(days: i));
          }
      }
    return startOfDate;

  }




  //Create the daily expense summary for implement in graph

  Map <String ,double>  getDailyExpenseSummary  ()
  {
    Map <String , double> dailyExpenseSummary={};


    for(var expense in overAllExpense)
      {
        String date = convertDateToString(expense.dateTime);
        double amount = double.parse(expense.amount);

        if(dailyExpenseSummary.containsKey(date))
          {
            double currentAmount = dailyExpenseSummary[date]!;
            currentAmount += amount;
            dailyExpenseSummary[date] = currentAmount;
          }
        else
          {
            dailyExpenseSummary.addAll({date : amount});
          }
      }
     return dailyExpenseSummary;
  }

}