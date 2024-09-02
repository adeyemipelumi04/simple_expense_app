import 'package:business/chart/chart.dart';
import 'package:business/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'expense_list/expenses_list.dart';

import 'package:business/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 3000,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Leisure",
        amount: 20.2020,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expenses deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child:
          Text("YO!, You haven't spend......\nStart spending and add expenses"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
      ),
      body: width < 600
          ? Column(children: [
              Chart(expenses: _registeredExpenses),
              Expanded(child: mainContent),
            ])
          : Row(children: [
              Expanded(child: Chart(expenses: _registeredExpenses)),
              Expanded(child: mainContent),
            ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        backgroundColor: const Color.fromARGB(255, 96, 59, 181),
        child: const Icon(Icons.add, size: 18),
      ),
    );
  }
}
