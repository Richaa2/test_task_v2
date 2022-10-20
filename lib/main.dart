import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_v2/api/bloc/country_bloc.dart';
import 'package:test_task_v2/api/repository.dart';

import 'main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//TODO зберігати svg в окрему штуку щоб воно загружалось роставити принципі годин 5 роботи десь)))
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CountryRepository(),
      child: BlocProvider(
        create: (context) => CountryBloc(
            countryRepository:
                RepositoryProvider.of<CountryRepository>(context)),
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xff8EAAFB),
          ),
          home: MainScreen(),
        ),
      ),
    );
  }
}
