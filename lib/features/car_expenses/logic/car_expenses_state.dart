import 'package:equatable/equatable.dart';
import 'package:flutter_practice10/features/car_expenses/models/expense_model.dart';

class CarExpensesState extends Equatable {
  final List<ExpenseModel> expenses;
  final ExpenseModel? recentlyRemovedExpense;
  final int? recentlyRemovedExpenseIndex;

  const CarExpensesState({
    this.expenses = const [],
    this.recentlyRemovedExpense,
    this.recentlyRemovedExpenseIndex,
  });

  double get totalAmount =>
      expenses.fold(0.0, (sum, item) => sum + item.amount);

  CarExpensesState copyWith({
    List<ExpenseModel>? expenses,
    ExpenseModel? recentlyRemovedExpense,
    int? recentlyRemovedExpenseIndex,
    bool clearRecentlyRemoved = false,
  }) {
    return CarExpensesState(
      expenses: expenses ?? this.expenses,
      recentlyRemovedExpense: clearRecentlyRemoved
          ? null
          : recentlyRemovedExpense ?? this.recentlyRemovedExpense,
      recentlyRemovedExpenseIndex: clearRecentlyRemoved
          ? null
          : recentlyRemovedExpenseIndex ?? this.recentlyRemovedExpenseIndex,
    );
  }

  @override
  List<Object?> get props =>
      [expenses, recentlyRemovedExpense, recentlyRemovedExpenseIndex];
}

