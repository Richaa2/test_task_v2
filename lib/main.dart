import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task_v2/api/bloc/country_bloc.dart';
import 'package:test_task_v2/api/repository.dart';

import 'main_screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            scaffoldBackgroundColor: const Color(0xff8EAAFB),
          ),
          home: const MainScreen(
            imageOfCountry: 'https://flagcdn.com/w320/ua.png',
            callingCode: '380',
          ),
        ),
      ),
    );
  }
}
