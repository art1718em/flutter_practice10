import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/service_history/logic/service_history_cubit.dart';
import 'package:flutter_practice10/features/service_history/logic/service_history_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pushReplacement('/expenses'),
        ),
        title: const Text('История обслуживания'),
      ),
      body: BlocBuilder<ServiceHistoryCubit, ServiceHistoryState>(
        builder: (context, state) {
          final records = state.serviceRecords;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return ListTile(
                title: Text(record.title),
                subtitle: Text(DateFormat('dd.MM.yyyy').format(record.date)),
                trailing: Text('${record.cost.toStringAsFixed(2)} руб.'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/history/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

