import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {


  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      dateTime: formatter.format(DateTime.now()),
      description: 'I bus a flutter course',
      category: Category.work,
    ),
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      dateTime: formatter.format(DateTime.now()),
      description: 'I bus a flutter course',
      category: Category.leisure,
    ),
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      dateTime: formatter.format(DateTime.now()),
      description: 'I bus a flutter course',
      category: Category.food,
    ),
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      dateTime: formatter.format(DateTime.now()),
      description: 'I bus a flutter course',
      category: Category.travel,
    ),
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      dateTime: formatter.format(DateTime.now()),
      description: 'I bus a flutter course',
      category: Category.travel,
    ),
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      dateTime: formatter.format(DateTime.now()),
      description: 'I bus a flutter course',
      category: Category.work,
    ),
   
    
  ];

  
  void _openAddExpensesOverlay(){
    showModalBottomSheet(
      context:context,
      isScrollControlled: true,
      builder:(ctx)=> NewExpense(addNewExpense:_addNewExpense),

      );
  }

  void _addNewExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });   
  }

  void _onRemoveExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content:Text(' "${expense.title}" Expense deleted..!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed:(){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }), 
      )
    );
    
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(expenses:_registeredExpenses,onRemove:_onRemoveExpense);
      
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        toolbarHeight: 40,
        title: const Text(
          'Expense Tracker'
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Chart(expenses: _registeredExpenses,),
            const SizedBox(height: 20,),
            Expanded(child: mainContent),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),

        onPressed:_openAddExpensesOverlay,
        label: const Icon(Icons.add,size: 30,),),
    );
  }
}