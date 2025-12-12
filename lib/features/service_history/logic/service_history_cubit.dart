import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/service_history/models/service_record_model.dart';
import 'service_history_state.dart';

class ServiceHistoryCubit extends Cubit<ServiceHistoryState> {
  ServiceHistoryCubit() : super(const ServiceHistoryState());

  void addServiceRecord(String title, double cost) {
    final newRecord = ServiceRecordModel(
      title: title,
      date: DateTime.now(),
      cost: cost,
    );
    final updatedRecords = List<ServiceRecordModel>.from(state.serviceRecords)
      ..add(newRecord);
    emit(state.copyWith(serviceRecords: updatedRecords));
  }
}

