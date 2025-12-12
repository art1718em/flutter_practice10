import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/car_expenses/models/expense_model.dart';
import 'package:uuid/uuid.dart';
import 'car_expenses_state.dart';

class CarExpensesCubit extends Cubit<CarExpensesState> {
  CarExpensesCubit() : super(const CarExpensesState());

  final _uuid = const Uuid();

  void addExpense(String title, double amount) {
    final newExpense = ExpenseModel(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    final updatedExpenses = List<ExpenseModel>.from(state.expenses)
      ..add(newExpense);
    emit(state.copyWith(expenses: updatedExpenses));
  }

  void removeExpense(String id) {
    final expenseIndex = state.expenses.indexWhere((expense) => expense.id == id);
    if (expenseIndex < 0) {
      return;
    }

    final expenseToRemove = state.expenses[expenseIndex];
    final updatedExpenses = List<ExpenseModel>.from(state.expenses)
      ..removeAt(expenseIndex);

    emit(state.copyWith(
      expenses: updatedExpenses,
      recentlyRemovedExpense: expenseToRemove,
      recentlyRemovedExpenseIndex: expenseIndex,
    ));
  }

  void undoRemove() {
    if (state.recentlyRemovedExpense != null &&
        state.recentlyRemovedExpenseIndex != null) {
      final updatedExpenses = List<ExpenseModel>.from(state.expenses)
        ..insert(state.recentlyRemovedExpenseIndex!,
            state.recentlyRemovedExpense!);
      emit(state.copyWith(
        expenses: updatedExpenses,
        clearRecentlyRemoved: true,
      ));
    }
  }

  void clearUndoState() {
    emit(state.copyWith(clearRecentlyRemoved: true));
  }
}

