import 'package:favorite_app_using_bloc_state_management_flutter/features/favorite/bloc/bloc/favorite_bloc.dart';
import 'package:favorite_app_using_bloc_state_management_flutter/features/favorite/repository/favorite_repository.dart';
import 'package:favorite_app_using_bloc_state_management_flutter/screen/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite App',

      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      // favorite representing a feature of the app
      home: BlocProvider(
        create: (context) => FavoriteBloc(FavoriteRepository()),
        child: const FavoriteScreen(),
      ),
    );
  }
}
