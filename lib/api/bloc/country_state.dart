part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class CountryInitialState extends CountryState {}

class CountryLoadingState extends CountryState {}

class CountryLoadedState extends CountryState {
  final List<Country> loadedCountries;
  CountryLoadedState({required this.loadedCountries});
}
