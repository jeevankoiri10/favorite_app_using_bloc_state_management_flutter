import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favorite_app_using_bloc_state_management_flutter/features/favorite/model/favorite_model.dart';
import 'package:favorite_app_using_bloc_state_management_flutter/features/favorite/repository/favorite_repository.dart';
import 'package:flutter/material.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteRepository favoriteRepository;

  FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial()) {
    on<FetchFavoriteList>(fetchList);

    on<ToggleFavoriteItem>(toggleFavourite);
    on<ToggleCheckbox>(toggleCheckbox);
    on<DeleteSelected>(deleteSelected);

    // Automatically trigger fetch on creation
    add(FetchFavoriteList());
  }

  void fetchList(event, emit) async {
    emit(FavoriteLoading());
    try {
      List<FavoriteModel> tempFavList = await favoriteRepository
          .fetchFavorites();
      emit(FavoriteSuccess(favoriteItemsList: tempFavList));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  void toggleFavourite(event, emit) async {
    if (state is FavoriteSuccess) {
      final currentState = state as FavoriteSuccess;
      final updatedList = currentState.favoriteItemsList.map((item) {
        return item.id == event.id
            ? item.copyWith(isFavorited: !item.isFavorited)
            : item;
      }).toList();
      emit(FavoriteSuccess(favoriteItemsList: updatedList));
    }
  }

  void toggleCheckbox(event, emit) async {
    if (state is FavoriteSuccess) {
      final currentState = state as FavoriteSuccess;
      final updatedList = currentState.favoriteItemsList.map((item) {
        return item.id == event.id
            ? item.copyWith(isDeleted: !item.isDeleted)
            : item;
      }).toList();
      emit(FavoriteSuccess(favoriteItemsList: updatedList));
    }
  }

  void deleteSelected(event, emit) async {
    if (state is FavoriteSuccess) {
      final currentState = state as FavoriteSuccess;
      final updatedList = currentState.favoriteItemsList.where((element) {
        return !element.isDeleted;
      }).toList();
      emit(FavoriteSuccess(favoriteItemsList: updatedList));
    }
  }
}
