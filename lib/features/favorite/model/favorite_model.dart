import 'package:equatable/equatable.dart';

// Favorite Model representing the data structure of a favorite item in the app
class FavoriteModel extends Equatable {
  final String id;
  final String name;
  final bool isFavorited;
  final bool isDeleted;

  const FavoriteModel({
    required this.id,
    required this.name,
    this.isFavorited = false,
    this.isDeleted = false,
  });

  FavoriteModel copyWith({
    String? id,
    String? name,
    bool? isFavorited,
    bool? isDeleted,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorited: isFavorited ?? this.isFavorited,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [id, name, isFavorited, isDeleted];
}
