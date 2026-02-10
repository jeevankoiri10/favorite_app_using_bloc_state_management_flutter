import 'package:favorite_app_using_bloc_state_management_flutter/features/favorite/bloc/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Screen'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FavoriteBloc>().add(FetchFavoriteList());
            },
            icon: Icon(Icons.restore),
          ),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              int selectedCount = 0;

              if (state is FavoriteSuccess) {
                selectedCount = state.favoriteItemsList
                    .where((element) => element.isDeleted)
                    .length;
              }
              return selectedCount == 0
                  ? Container()
                  : Badge(
                      label: Text(selectedCount.toString()),
                      child: IconButton(
                        onPressed: () {
                          context.read<FavoriteBloc>().add(DeleteSelected());
                        },
                        icon: selectedCount == 0
                            ? Container()
                            : Icon(Icons.delete),
                      ),
                    );
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return switch (state) {
            (FavoriteInitial()) => CircularProgressIndicator(),

            (FavoriteLoading()) => CircularProgressIndicator(),

            (FavoriteFailure(error: var message)) => Text('error: $message'),

            (FavoriteSuccess(favoriteItemsList: var tempList)) =>
              ListView.builder(
                itemCount: tempList.length,
                itemBuilder: (context, index) {
                  final oneItem = tempList[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(index.toString())),
                    title: Text('${oneItem.id}. ${oneItem.name}'),
                    trailing: SizedBox(
                      height: 200,
                      width: 200,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              debugPrint('pressed fav: id ${oneItem.id}');
                              context.read<FavoriteBloc>().add(
                                ToggleFavoriteItem(id: oneItem.id),
                              );
                            },
                            icon: oneItem.isFavorited
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_outline),
                          ),
                          Checkbox(
                            value: oneItem.isDeleted,
                            onChanged: (value) {
                              debugPrint('Will be deleted');
                              debugPrint('pressed fav: id ${oneItem.id}');
                              context.read<FavoriteBloc>().add(
                                ToggleCheckbox(id: oneItem.id),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          };
        },
      ),
    );
  }
}
