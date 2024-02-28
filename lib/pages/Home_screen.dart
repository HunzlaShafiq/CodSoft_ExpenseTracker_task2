import 'package:task1_expense_tracker/components/Bar_Summary.dart';
import 'package:task1_expense_tracker/components/Expense_Tile.dart';
import 'package:task1_expense_tracker/data/Expense_Data.dart';
import 'package:task1_expense_tracker/models/Expense_item.dart';
import'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController addExpenseNameController = TextEditingController();
  TextEditingController addExpenseAmountController = TextEditingController();

  @override
  void initState() {

    super.initState();
    Provider.of<ExpenseData>(context,listen: false).prepareData();
  }

  void addExpense()
  {
    showDialog(

        context: context,
        builder: (context)=> AlertDialog(

          title:const Text("Add New Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: addExpenseNameController ,
                decoration:const InputDecoration(
                  hintText: 'New Expense'
                ),
              ),
              TextField(
                controller: addExpenseAmountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Rupees'
                ),
              )
            ],
          ),
          actions: [
            MaterialButton(
                onPressed: save,
              child:const Text('Add'),
            ),
            MaterialButton(
                onPressed: cancel,
              child:const Text('Cancel'),
            )
          ],
        )
    );
  }

  void deleteExpense(ExpenseItem expense)
  {
    Provider.of<ExpenseData>(context,listen: false).deleteItem(expense);
  }

  void save ()
  {
    if(addExpenseNameController.text.isNotEmpty&& addExpenseAmountController.text.isNotEmpty)
      {
        ExpenseItem newExpense = ExpenseItem(
            name: addExpenseNameController.text,
            amount: addExpenseAmountController.text,
            dateTime: DateTime.now()
        );
        Provider.of<ExpenseData>(context,listen: false).addNewItem(newExpense);
      }
    Navigator.pop(context);
    clear();
  }
  void cancel ()
  {
    Navigator.pop(context);
    clear();
  }
  // clear text fields controller
  void clear ()
  {
    addExpenseAmountController.clear();
    addExpenseNameController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context,value,child) =>Scaffold(
          appBar: AppBar(
            backgroundColor:const Color(0xff40E0D0),
            title:const Text('Personal Expense Tracker'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: addExpense,
            backgroundColor:const Color(0xff40E0D0),
            child:const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BarSummary(startOfWeek: value.startOfDate()),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getExpenseList().length,
                  itemBuilder: (context,index)=>
                      ExpenseTile(
                          name: value.getExpenseList()[index].name,
                          amount: value.getExpenseList()[index].amount,
                          dateTime: value.getExpenseList()[index].dateTime,
                          deleteExpense: (p0)=>deleteExpense(value.getExpenseList()[index]),
                      )
              ),
            ],
          ),
        )

    );
  }
}
