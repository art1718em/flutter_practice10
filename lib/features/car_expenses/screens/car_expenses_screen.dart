import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../logic/car_expenses_cubit.dart';
import '../logic/car_expenses_state.dart';
import '../widgets/expense_table.dart';

class CarExpensesScreen extends StatelessWidget {
  const CarExpensesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarExpensesCubit, CarExpensesState>(
      listener: (context, state) {
        if (state.recentlyRemovedExpense != null) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(
                SnackBar(
                  content: const Text('Расход удален'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'ОТМЕНИТЬ',
                    onPressed: () {
                      context.read<CarExpensesCubit>().undoRemove();
                    },
                  ),
                ),
              )
              .closed
              .then((reason) {
            if (reason != SnackBarClosedReason.action) {
              context.read<CarExpensesCubit>().clearUndoState();
            }
          });
        }
      },
      builder: (context, state) {
        final expenses = state.expenses;
        final totalAmount = state.totalAmount;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leadingWidth: 100,
            leading: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'Информация',
                  onPressed: () => context.pushReplacement('/info'),
                ),
                IconButton(
                  icon: const Icon(Icons.history),
                  tooltip: 'История',
                  onPressed: () => context.pushReplacement('/history'),
                ),
              ],
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://cdn-icons-png.flaticon.com/512/2921/2921222.png",
                  width: 30,
                  height: 30,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 8),
                Text('Расходы: ${totalAmount.toStringAsFixed(2)} руб.'),
              ],
            ),
          ),
          body: ExpenseTable(
            expenses: expenses,
            onRemove: (id) =>
                context.read<CarExpensesCubit>().removeExpense(id),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/expenses/add'),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

