import 'package:task1_expense_tracker/data/Expense_Data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'pages/Home_screen.dart';

void main() async{
  //initialize hive
  await Hive.initFlutter();

  //open hive box
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create:(context)=> ExpenseData(),
      builder: (context,child) =>const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        home: Home_Screen(),
      )
    );
  }
}

