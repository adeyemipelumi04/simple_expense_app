import 'package:business/widgets/expense_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:business/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.onRemoveExpense, required this.expenses});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed: (direction) => onRemoveExpense(expenses[index]),
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenses[index]))),
      itemCount: expenses.length,
    );
  }
}
