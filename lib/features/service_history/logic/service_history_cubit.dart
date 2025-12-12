import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/service_history/models/service_record_model.dart';
import 'package:uuid/uuid.dart';
import 'service_history_state.dart';

class ServiceHistoryCubit extends Cubit<ServiceHistoryState> {
  ServiceHistoryCubit() : super(const ServiceHistoryState());

  final _uuid = const Uuid();

  void addServiceRecord(String vehicleId, String title, double cost) {
    final newRecord = ServiceRecordModel(
      id: _uuid.v4(),
      vehicleId: vehicleId,
      title: title,
      date: DateTime.now(),
      cost: cost,
    );
    final updatedRecords = List<ServiceRecordModel>.from(state.serviceRecords)
      ..add(newRecord);
    emit(state.copyWith(serviceRecords: updatedRecords));
  }

  void clearServiceHistory() {
    emit(const ServiceHistoryState());
  }
}

