import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'budget_store.dart';
import 'home_page.dart';

void main() {
  final budgetStore = BudgetStore();

  runApp(MyApp(budgetStore: budgetStore));
}

class MyApp extends StatelessWidget {
  final BudgetStore budgetStore;

  const MyApp({super.key, required this.budgetStore});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Manager',
      home: HomePage(budgetStore: budgetStore),
    );
  }
}
