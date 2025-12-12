import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/service_history/models/service_record_model.dart';
import 'package:uuid/uuid.dart';
import 'service_history_state.dart';

class ServiceHistoryCubit extends Cubit<ServiceHistoryState> {
  ServiceHistoryCubit() : super(const ServiceHistoryState());

  final _uuid = const Uuid();

  void addServiceRecord({
    required String vehicleId,
    required String title,
    required ServiceType type,
    required DateTime date,
    int? mileage,
    List<String>? worksDone,
    String? serviceCenter,
    String? notes,
    DateTime? nextServiceDate,
  }) {
    final newRecord = ServiceRecordModel(
      id: _uuid.v4(),
      vehicleId: vehicleId,
      title: title,
      type: type,
      date: date,
      mileage: mileage,
      worksDone: worksDone ?? [],
      serviceCenter: serviceCenter,
      notes: notes,
      nextServiceDate: nextServiceDate,
    );
    final updatedRecords = List<ServiceRecordModel>.from(state.serviceRecords)
      ..add(newRecord);
    emit(state.copyWith(serviceRecords: updatedRecords));
  }

  void deleteServiceRecord(String id) {
    final updatedRecords = state.serviceRecords.where((r) => r.id != id).toList();
    emit(state.copyWith(serviceRecords: updatedRecords));
  }

  void clearServiceHistory() {
    emit(const ServiceHistoryState());
  }
}

