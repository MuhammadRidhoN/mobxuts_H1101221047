import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'budget_store.dart';

class HomePage extends StatelessWidget {
  final Color primaryColor = const Color(0xFF5C6BC0);
  final Color accentColor = const Color(0xFF3949AB);
  final Color incomeColor = const Color(0xFF66BB6A);
  final Color expenseColor = const Color(0xFFEF5350);
  final Color backgroundColor = const Color(0xFFF5F7FA);

  final BudgetStore budgetStore;

  HomePage({super.key, required this.budgetStore});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      double totalIncome = budgetStore.totalIncome;
      double totalExpenses = budgetStore.totalExpenses;
      double total = budgetStore.total;

      return Scaffold(
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(context, total),
            SliverToBoxAdapter(
                child: _buildSummaryCards(totalIncome, totalExpenses)),
            SliverToBoxAdapter(child: _buildRecentTransactionsHeader()),
            _buildTransactionsList(budgetStore.budgets),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddBudgetDialog(context),
          backgroundColor: accentColor,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget _buildAppBar(BuildContext context, double total) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, accentColor],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Balance',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(total)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(double income, double expenses) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
              child: _buildSummaryCard(
                  'Income', income, incomeColor, Icons.arrow_upward)),
          const SizedBox(width: 16),
          Expanded(
              child: _buildSummaryCard(
                  'Expenses', expenses, expenseColor, Icons.arrow_downward)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, double amount, Color color, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(title,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(amount)}',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactionsHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Recent Transactions',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
      ),
    );
  }

  Widget _buildTransactionsList(ObservableList<Budget> budgets) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final budget = budgets[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: budget.isExpense ? expenseColor : incomeColor,
                child: Icon(
                  budget.isExpense ? Icons.remove : Icons.add,
                  color: Colors.white,
                ),
              ),
              title: Text(budget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(budget.isExpense ? 'Expense' : 'Income'),
              trailing: Text(
                'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(budget.amount)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: budget.isExpense ? expenseColor : incomeColor,
                ),
              ),
            ),
          );
        },
        childCount: budgets.length,
      ),
    );
  }

  void _showAddBudgetDialog(BuildContext context) {
    String name = '';
    String amount = '';
    bool isExpense = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Transaction'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => name = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => amount = value,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Is Expense?'),
                      value: isExpense,
                      onChanged: (value) {
                        setState(() {
                          isExpense = value;
                        });
                      },
                      activeColor: accentColor,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (name.isNotEmpty && amount.isNotEmpty) {
                      final budget = Budget(name, double.parse(amount),
                          isExpense: isExpense);
                      budgetStore.addBudget(budget);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
