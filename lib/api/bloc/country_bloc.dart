import 'package:bloc/bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:meta/meta.dart';
import 'package:test_task_v2/api/repository.dart';

import '../../country.dart';

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
