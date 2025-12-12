import 'package:equatable/equatable.dart';
import 'package:flutter_practice10/features/service_history/models/service_record_model.dart';

class ServiceHistoryState extends Equatable {
  final List<ServiceRecordModel> serviceRecords;

  const ServiceHistoryState({
    this.serviceRecords = const [],
  });

  ServiceHistoryState copyWith({
    List<ServiceRecordModel>? serviceRecords,
  }) {
    return ServiceHistoryState(
      serviceRecords: serviceRecords ?? this.serviceRecords,
    );
  }

  @override
  List<Object> get props => [serviceRecords];
}

