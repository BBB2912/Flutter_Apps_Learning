import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key,required this.expenses});

  final List<Expense> expenses;


  List<ExpenseBucket> get buckets{
    return [
      ExpenseBucket.forCategory(expenses,Category.food ),
      ExpenseBucket.forCategory(expenses,Category.travel  ),
      ExpenseBucket.forCategory(expenses,Category.leisure),
      ExpenseBucket.forCategory(expenses,Category.work)
    ];
  }
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  
  @override
  Widget build(BuildContext context) {
    

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primaryContainer,
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).colorScheme.tertiaryContainer,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
        
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets.map((bucket) {
                final fill = bucket.totalExpenses == 0
                ? 0.0
                : bucket.totalExpenses/ maxTotalExpense;
                return ChartBar(fill: fill,
                    );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buckets.map((bucket)=>
            Expanded(child: 
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 4),
              child: categoryIcons[bucket.category], 
            )
            )
            ).toList()

          ),
        ],
      ),
    );
  }
}