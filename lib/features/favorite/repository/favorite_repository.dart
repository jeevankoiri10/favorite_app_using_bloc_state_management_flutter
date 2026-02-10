import 'dart:core';

import 'package:favorite_app_using_bloc_state_management_flutter/features/favorite/model/favorite_model.dart';

class FavoriteRepository {
  Future<List<FavoriteModel>> fetchFavorites() async {
    await Future.delayed(Duration(seconds: 2));

    return List.of(_generateList(20));
  }

  // function to generate lenth List of favorites of type FavoriteModel.
  List<FavoriteModel> _generateList(int length) {
    return List.generate(length, (index) {
      return FavoriteModel(id: index.toString(), name: 'Name: $index');
    });
  }

  //
}
