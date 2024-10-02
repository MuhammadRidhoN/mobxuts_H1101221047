// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BudgetStore on _BudgetStore, Store {
  Computed<double>? _$totalIncomeComputed;

  @override
  double get totalIncome =>
      (_$totalIncomeComputed ??= Computed<double>(() => super.totalIncome,
              name: '_BudgetStore.totalIncome'))
          .value;
  Computed<double>? _$totalExpensesComputed;

  @override
  double get totalExpenses =>
      (_$totalExpensesComputed ??= Computed<double>(() => super.totalExpenses,
              name: '_BudgetStore.totalExpenses'))
          .value;
  Computed<double>? _$totalComputed;

  @override
  double get total => (_$totalComputed ??=
          Computed<double>(() => super.total, name: '_BudgetStore.total'))
      .value;

  late final _$budgetsAtom =
      Atom(name: '_BudgetStore.budgets', context: context);

  @override
  ObservableList<Budget> get budgets {
    _$budgetsAtom.reportRead();
    return super.budgets;
  }

  @override
  set budgets(ObservableList<Budget> value) {
    _$budgetsAtom.reportWrite(value, super.budgets, () {
      super.budgets = value;
    });
  }

  late final _$_BudgetStoreActionController =
      ActionController(name: '_BudgetStore', context: context);

  @override
  void addBudget(Budget budget) {
    final _$actionInfo = _$_BudgetStoreActionController.startAction(
        name: '_BudgetStore.addBudget');
    try {
      return super.addBudget(budget);
    } finally {
      _$_BudgetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
budgets: ${budgets},
totalIncome: ${totalIncome},
totalExpenses: ${totalExpenses},
total: ${total}
    ''';
  }
}
