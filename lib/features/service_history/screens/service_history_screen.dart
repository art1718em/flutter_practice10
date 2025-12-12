import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/service_history/logic/service_history_cubit.dart';
import 'package:flutter_practice10/features/service_history/logic/service_history_state.dart';
import 'package:flutter_practice10/features/settings/logic/settings_cubit.dart';
import 'package:flutter_practice10/features/settings/logic/settings_state.dart';
import 'package:flutter_practice10/features/vehicles/logic/vehicles_cubit.dart';
import 'package:flutter_practice10/features/vehicles/logic/vehicles_state.dart';
import 'package:flutter_practice10/shared/utils/format_helpers.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehiclesCubit, VehiclesState>(
      builder: (context, vehiclesState) {
        final activeVehicle = vehiclesState.activeVehicle;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pushReplacement('/expenses'),
            ),
            title: activeVehicle != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'История обслуживания',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${activeVehicle.brand} ${activeVehicle.model}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                : const Text('История обслуживания'),
          ),
          body: activeVehicle == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_car_outlined,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Нет активного автомобиля',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/vehicles'),
                        icon: const Icon(Icons.add),
                        label: const Text('Добавить автомобиль'),
                      ),
                    ],
                  ),
                )
              : BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, settingsState) {
                    final currency = settingsState.settings.currency;

                    return BlocBuilder<ServiceHistoryCubit, ServiceHistoryState>(
                      builder: (context, state) {
                        final records = state.getRecordsByVehicle(activeVehicle.id);
                        
                        if (records.isEmpty) {
                          return const Center(
                            child: Text('История обслуживания пуста'),
                          );
                        }

                        return ListView.builder(
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            final record = records[index];
                            return ListTile(
                              title: Text(record.title),
                              subtitle: Text(DateFormat('dd.MM.yyyy').format(record.date)),
                              trailing: Text(
                                FormatHelpers.formatCurrency(record.cost, currency),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
          floatingActionButton: activeVehicle != null
              ? FloatingActionButton(
                  onPressed: () => context.push('/history/add'),
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}

