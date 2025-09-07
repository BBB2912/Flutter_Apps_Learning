import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key,required this.expenses,required this.onRemove});

  final List<Expense> expenses;
  final void Function(Expense expense)  onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context,index){
        final  expense=expenses[index];
        return  Dismissible(
          key:ValueKey(expense),
          direction: DismissDirection.endToStart,
          onDismissed: (direction){
             onRemove(expense);
          } ,
          child: ExpenseItem(expense:expense),
          );
          
      }
    );
  }
}