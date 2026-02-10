part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

// 1. Initial State (No data yet)
final class FavoriteInitial extends FavoriteState {}

// 2. Loading State (Usually for the first fetch)
final class FavoriteLoading extends FavoriteState {}

// 3. Success State (Holds your data)
final class FavoriteSuccess extends FavoriteState {
  final List<FavoriteModel> favoriteItemsList;

  const FavoriteSuccess({required this.favoriteItemsList});

  @override
  List<Object> get props => [favoriteItemsList];
}

// 4. Failure State (Holds the error message)
final class FavoriteFailure extends FavoriteState {
  final String error;
  const FavoriteFailure(this.error);

  @override
  List<Object> get props => [error];
}
