import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

enum Category{
  food,
  travel,
  leisure,
  work,
}

final Map<Category,Icon> categoryIcons ={
  Category.food: const Icon(Icons.lunch_dining),
  Category.travel:const Icon(Icons.flight_takeoff),
  Category.leisure:const Icon(Icons.movie),
  Category.work:const Icon(Icons.work),
};

final formatter=DateFormat.yMd();
const uuid=Uuid();
class Expense {
  final String id;
  final String title;
  final String description;
  final double amount;
  final Category category;
  final String dateTime;

   Expense(
    {
      required this.title,
      required this.description,
      required this.amount,
      required this.category,
      required this.dateTime,
      }):id=uuid.v4();
   
    
}

class ExpenseBucket{

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    :expenses=allExpenses
      .where((expense)=>expense.category==category)
      .toList();
  
  final Category category;
  final List<Expense> expenses;
  
  double get totalExpenses{
    double total=0;
    for(final expense in expenses){
      total+=expense.amount;
    }
    return total;
  }
}