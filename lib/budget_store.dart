import 'package:mobx/mobx.dart';
part 'budget_store.g.dart';

class Budget {
  String name;
  double amount;
  bool isExpense;

  Budget(this.name, this.amount, {required this.isExpense});
}

class BudgetStore = _BudgetStore with _$BudgetStore;

abstract class _BudgetStore with Store {
  @observable
  ObservableList<Budget> budgets = ObservableList<Budget>();

  @action
  void addBudget(Budget budget) {
    budgets.add(budget);
  }

  @computed
  double get totalIncome =>
      budgets.where((b) => !b.isExpense).fold(0.0, (sum, b) => sum + b.amount);

  @computed
  double get totalExpenses =>
      budgets.where((b) => b.isExpense).fold(0.0, (sum, b) => sum + b.amount);

  @computed
  double get total => totalIncome - totalExpenses;
}
