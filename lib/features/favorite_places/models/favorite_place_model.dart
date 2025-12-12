enum PlaceType {
  service,
  carWash,
  tireService,
  gasStation,
  parts,
}

extension PlaceTypeExtension on PlaceType {
  String get displayName {
    switch (this) {
      case PlaceType.service:
        return 'СТО';
      case PlaceType.carWash:
        return 'Автомойка';
      case PlaceType.tireService:
        return 'Шиномонтаж';
      case PlaceType.gasStation:
        return 'АЗС';
      case PlaceType.parts:
        return 'Автомагазин';
    }
  }

  String get icon {
    switch (this) {
      case PlaceType.service:
        return '🔧';
      case PlaceType.carWash:
        return '🚿';
      case PlaceType.tireService:
        return '🛞';
      case PlaceType.gasStation:
        return '⛽';
      case PlaceType.parts:
        return '🛒';
    }
  }
}

class FavoritePlaceModel {
  final String id;
  final String name;
  final PlaceType type;
  final String address;
  final String? phone;
  final double rating;
  final String? notes;
  final DateTime? lastVisit;

  FavoritePlaceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    this.phone,
    this.rating = 0.0,
    this.notes,
    this.lastVisit,
  });

  FavoritePlaceModel copyWith({
    String? id,
    String? name,
    PlaceType? type,
    String? address,
    String? phone,
    double? rating,
    String? notes,
    DateTime? lastVisit,
  }) {
    return FavoritePlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      rating: rating ?? this.rating,
      notes: notes ?? this.notes,
      lastVisit: lastVisit ?? this.lastVisit,
    );
  }
}

