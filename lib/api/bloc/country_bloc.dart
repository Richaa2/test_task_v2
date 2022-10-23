// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/country.dart';
import '../repository.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository countryRepository;
  CountryBloc({required this.countryRepository})
      : super(CountryInitialState()) {
    on<CountryLoadEvent>((event, emit) async {
      emit(CountryLoadingState());

      try {
        final List<Country> loadedCountryList =
            await countryRepository.getAllCountry();

        emit(CountryLoadedState(
          loadedCountries: loadedCountryList,
          filledField: false,
        ));
      } catch (e) {
        print(e.toString());
      }
    });

    on<CountryFillEvent>(
      ((event, emit) {
        try {
          emit(CountryLoadedState(
            loadedCountries: event.loadedCountries,
            filledField: false,
          ));
        } catch (e) {
          print(e.toString());
        }
      }),
    );
  }
}
