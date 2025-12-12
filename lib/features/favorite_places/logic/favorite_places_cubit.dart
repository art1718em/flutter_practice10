import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/favorite_places/models/favorite_place_model.dart';
import 'package:uuid/uuid.dart';
import 'favorite_places_state.dart';

class FavoritePlacesCubit extends Cubit<FavoritePlacesState> {
  FavoritePlacesCubit() : super(const FavoritePlacesState());

  final _uuid = const Uuid();

  void addPlace({
    required String name,
    required PlaceType type,
    required String address,
    String? phone,
    double rating = 0.0,
    String? notes,
  }) {
    final newPlace = FavoritePlaceModel(
      id: _uuid.v4(),
      name: name,
      type: type,
      address: address,
      phone: phone,
      rating: rating,
      notes: notes,
    );

    final updatedPlaces = List<FavoritePlaceModel>.from(state.places)
      ..add(newPlace);
    emit(state.copyWith(places: updatedPlaces));
  }

  void updatePlace(FavoritePlaceModel updatedPlace) {
    final placeIndex = state.places.indexWhere((p) => p.id == updatedPlace.id);
    if (placeIndex < 0) return;

    final updatedPlaces = List<FavoritePlaceModel>.from(state.places);
    updatedPlaces[placeIndex] = updatedPlace;

    emit(state.copyWith(places: updatedPlaces));
  }

  void deletePlace(String id) {
    final updatedPlaces = state.places.where((p) => p.id != id).toList();
    emit(state.copyWith(places: updatedPlaces));
  }

  void markVisited(String id) {
    final placeIndex = state.places.indexWhere((p) => p.id == id);
    if (placeIndex < 0) return;

    final updatedPlace = state.places[placeIndex].copyWith(
      lastVisit: DateTime.now(),
    );

    final updatedPlaces = List<FavoritePlaceModel>.from(state.places);
    updatedPlaces[placeIndex] = updatedPlace;

    emit(state.copyWith(places: updatedPlaces));
  }

  void setFilter(PlaceType? type) {
    emit(state.copyWith(selectedType: type, clearFilter: type == null));
  }

  void clearPlaces() {
    emit(const FavoritePlacesState());
  }
}

