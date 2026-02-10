part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteList extends FavoriteEvent {}

class ToggleFavoriteItem extends FavoriteEvent {
  String id;
  ToggleFavoriteItem({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class ToggleCheckbox extends FavoriteEvent {
  String id;
  ToggleCheckbox({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class DeleteSelected extends FavoriteEvent {}
