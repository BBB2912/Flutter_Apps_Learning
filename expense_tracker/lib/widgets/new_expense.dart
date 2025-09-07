import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});

  final void Function(Expense expense) addNewExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _expenseTitleCotroller = TextEditingController();
  final _expenseDescrptionCotroller = TextEditingController();
  final _expenseAmountController = TextEditingController();
  final _dateController = TextEditingController();
  Category _selectedCategory = Category.leisure;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {

        _dateController.text = formatter.format(picked);
      });
    }
  }

  void _onSubmit() {
    var valuesEmpty = '';

    if (_expenseTitleCotroller.text.isEmpty) {
      valuesEmpty += '- Expense Title\n';
    }
    if (_expenseDescrptionCotroller.text.isEmpty) {
      valuesEmpty += '- Expense Description\n';
    }
    if (_expenseAmountController.text.isEmpty) {
      valuesEmpty += '- Expense Amount\n';
    }
    if (_dateController.text.isEmpty) {
      valuesEmpty += '- Expense Date';
    }

    if (valuesEmpty != '') {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.purpleAccent,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Column(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.yellow,
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please enter the following feilds',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 100, 2, 2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  valuesEmpty,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final Expense expense = Expense(
      title: _expenseTitleCotroller.text,
      description: _expenseDescrptionCotroller.text,
      amount: double.parse(_expenseAmountController.text),
      category: _selectedCategory,
      dateTime: _dateController.text,
    );
    widget.addNewExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _expenseTitleCotroller.dispose();
    _expenseDescrptionCotroller.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          //Title of scree
          const Text('Enter New Expense', textAlign: TextAlign.center),
          //expense title
          TextField(
            controller: _expenseTitleCotroller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: const Text('Expense Title'),
              hintText: 'e.g. Lunch, Taxi',
            ),
          ),
          const SizedBox(height: 10),
          //expense description
          TextField(
            controller: _expenseDescrptionCotroller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text('Expense Description'),
              hintText: 'e.g. Office lunch with team',
            ),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //expense amount
              Expanded(
                child: TextField(
                  controller: _expenseAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount (INR)'),
                    prefix: Text('₹ '),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              //expense category
              Expanded(
                child: DropdownButtonFormField<Category>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    label: Text('Date'),
                    hintText: 'dd/mm/yyyy',
                  ),
                ),
              ),
              IconButton(
                onPressed: _pickDate,
                icon: Icon(Icons.calendar_today),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _onSubmit,
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
