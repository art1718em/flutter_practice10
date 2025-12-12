enum ServiceType {
  maintenance('Плановое ТО', '🔧'),
  repair('Ремонт', '🔨'),
  diagnostics('Диагностика', '🔍'),
  tuning('Тюнинг', '⚙️'),
  carWash('Мойка', '💧'),
  other('Другое', '📋');

  final String displayName;
  final String icon;
  const ServiceType(this.displayName, this.icon);
}

class ServiceRecordModel {
  final String id;
  final String vehicleId;
  final String title;
  final ServiceType type;
  final DateTime date;
  final int? mileage; // Пробег на момент обслуживания
  final List<String> worksDone; // Список выполненных работ
  final String? serviceCenter; // Название СТО
  final String? notes; // Дополнительные заметки
  final DateTime? nextServiceDate; // Дата следующего ТО

  ServiceRecordModel({
    required this.id,
    required this.vehicleId,
    required this.title,
    required this.type,
    required this.date,
    this.mileage,
    this.worksDone = const [],
    this.serviceCenter,
    this.notes,
    this.nextServiceDate,
  });

  ServiceRecordModel copyWith({
    String? id,
    String? vehicleId,
    String? title,
    ServiceType? type,
    DateTime? date,
    int? mileage,
    List<String>? worksDone,
    String? serviceCenter,
    String? notes,
    DateTime? nextServiceDate,
  }) {
    return ServiceRecordModel(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      title: title ?? this.title,
      type: type ?? this.type,
      date: date ?? this.date,
      mileage: mileage ?? this.mileage,
      worksDone: worksDone ?? this.worksDone,
      serviceCenter: serviceCenter ?? this.serviceCenter,
      notes: notes ?? this.notes,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
    );
  }
}

