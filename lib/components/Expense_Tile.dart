import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name, amount;
  final DateTime dateTime;
  void Function (BuildContext)? deleteExpense;
  ExpenseTile({super.key,required this.name,required this.deleteExpense,required this.amount,required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          motion:const StretchMotion(), 
          children: [
            SlidableAction(
                onPressed: deleteExpense,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(5),
              flex: 4,

            )
          ]
      ),
      child: ListTile(
        tileColor: Colors.teal.withOpacity(.1),
        title: Text(name),
        trailing: Text('RS $amount'),
        subtitle: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}"),
      ),
    );
  }
}

