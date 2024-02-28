import 'package:task1_expense_tracker/DateConverter/Date_Convert_To_String.dart';
import 'package:task1_expense_tracker/bar%20graph/Bar_Graph.dart';
import 'package:task1_expense_tracker/data/Expense_Data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarSummary extends StatelessWidget {
  final DateTime? startOfWeek;

  const BarSummary({super.key,required this.startOfWeek});

  double calculateMax (ExpenseData value,String sunday, String monday,String tuesday, String wednesday,String thursday, String friday,String saturday)
  {
    double? max =100;
    List<double> values=[
      value.getDailyExpenseSummary()[sunday] ?? 0,
      value.getDailyExpenseSummary()[monday] ?? 0,
      value.getDailyExpenseSummary()[tuesday] ?? 0,
      value.getDailyExpenseSummary()[wednesday] ?? 0,
      value.getDailyExpenseSummary()[thursday] ?? 0,
      value.getDailyExpenseSummary()[friday] ?? 0,
      value.getDailyExpenseSummary()[saturday] ?? 0
    ];

    values.sort();
    
    max =values.last *1.1;
    return max ==0 ? 100: max ;

  }

  double calculateTotal(ExpenseData value,String sunday, String monday,String tuesday, String wednesday,String thursday, String friday,String saturday)
  {
    double totalValue=0;
    List<double> values=[
      value.getDailyExpenseSummary()[sunday] ?? 0,
      value.getDailyExpenseSummary()[monday] ?? 0,
      value.getDailyExpenseSummary()[tuesday] ?? 0,
      value.getDailyExpenseSummary()[wednesday] ?? 0,
      value.getDailyExpenseSummary()[thursday] ?? 0,
      value.getDailyExpenseSummary()[friday] ?? 0,
      value.getDailyExpenseSummary()[saturday] ?? 0
    ];

    for(int i=0 ; i<values.length; i++)
      {
        totalValue+=values[i];
      }
    return totalValue;
  }


  @override
  Widget build(BuildContext context) {
    //calculate Maximum value



    //get ddmmyyyy for everyday of this week
    String sunday = convertDateToString(startOfWeek!.add(const Duration(days: 0)));
    String monday = convertDateToString(startOfWeek!.add(const Duration(days: 1)));
    String tuesday = convertDateToString(startOfWeek!.add(const Duration(days: 2)));
    String wednesday = convertDateToString(startOfWeek!.add(const Duration(days: 3)));
    String thursday = convertDateToString(startOfWeek!.add(const Duration(days: 4)));
    String friday = convertDateToString(startOfWeek!.add(const Duration(days: 5)));
    String saturday = convertDateToString(startOfWeek!.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context,value,child)
        =>Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:const Color(0xff40E0D0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Week Total ', style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(width: 15,),
                      Text('RS : ${calculateTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}')
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: MyBarGraph(
                  maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
                  sunAmount: value.getDailyExpenseSummary()[sunday] ?? 0,
                  monAmount: value.getDailyExpenseSummary()[monday] ?? 0,
                  tueAmount: value.getDailyExpenseSummary()[tuesday] ?? 0,
                  wedAmount: value.getDailyExpenseSummary()[wednesday] ?? 0,
                  thurAmount: value.getDailyExpenseSummary()[thursday] ?? 0,
                  friAmount: value.getDailyExpenseSummary()[friday] ?? 0,
                  satAmount: value.getDailyExpenseSummary()[saturday] ?? 0
              ),
            ),
          ],
        )
    ) ;
  }
}