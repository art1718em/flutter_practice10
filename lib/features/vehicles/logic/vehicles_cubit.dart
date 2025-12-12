import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/vehicles/models/vehicle_model.dart';
import 'package:uuid/uuid.dart';
import 'vehicles_state.dart';

class VehiclesCubit extends Cubit<VehiclesState> {
  VehiclesCubit() : super(const VehiclesState());

  final _uuid = const Uuid();

  void addVehicle({
    required String brand,
    required String model,
    required int year,
    String? vin,
    String? licensePlate,
    String? color,
    int? mileage,
    DateTime? purchaseDate,
  }) {
    final updatedVehicles = state.vehicles.map((v) {
      return v.copyWith(isActive: false);
    }).toList();

    final newVehicle = VehicleModel(
      id: _uuid.v4(),
      brand: brand,
      model: model,
      year: year,
      vin: vin,
      licensePlate: licensePlate,
      color: color,
      mileage: mileage,
      purchaseDate: purchaseDate,
      isActive: true,
    );

    updatedVehicles.add(newVehicle);
    
    emit(state.copyWith(
      vehicles: updatedVehicles,
      activeVehicle: newVehicle,
    ));
  }

  void updateVehicle(VehicleModel updatedVehicle) {
    final vehicleIndex = state.vehicles.indexWhere((v) => v.id == updatedVehicle.id);
    if (vehicleIndex < 0) return;

    final updatedVehicles = List<VehicleModel>.from(state.vehicles);
    updatedVehicles[vehicleIndex] = updatedVehicle;

    emit(state.copyWith(
      vehicles: updatedVehicles,
      activeVehicle: state.activeVehicle?.id == updatedVehicle.id ? updatedVehicle : null,
    ));
  }

  void deleteVehicle(String id) {
    final updatedVehicles = state.vehicles.where((v) => v.id != id).toList();
    
    VehicleModel? newActiveVehicle = state.activeVehicle;
    if (state.activeVehicle?.id == id) {
      newActiveVehicle = updatedVehicles.isNotEmpty ? updatedVehicles.first : null;
      if (newActiveVehicle != null) {
        final index = updatedVehicles.indexWhere((v) => v.id == newActiveVehicle!.id);
        updatedVehicles[index] = newActiveVehicle.copyWith(isActive: true);
      }
    }

    emit(state.copyWith(
      vehicles: updatedVehicles,
      activeVehicle: newActiveVehicle,
      clearActiveVehicle: newActiveVehicle == null,
    ));
  }

  void setActiveVehicle(String id) {
    final vehicle = state.vehicles.firstWhere((v) => v.id == id);
    
    final updatedVehicles = state.vehicles.map((v) {
      return v.copyWith(isActive: v.id == id);
    }).toList();

    emit(state.copyWith(
      vehicles: updatedVehicles,
      activeVehicle: vehicle.copyWith(isActive: true),
    ));
  }

  void clearVehicles() {
    emit(const VehiclesState());
  }
}

