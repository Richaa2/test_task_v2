part of 'country_bloc.dart';

@immutable
abstract class CountryEvent {}

class CountryLoadEvent extends CountryEvent {}

class CountryFillEvent extends CountryEvent {
  final List<Country> loadedCountries;

  CountryFillEvent(this.loadedCountries);
}
