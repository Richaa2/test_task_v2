import 'package:test_task_v2/api/get_country.dart';
import 'package:test_task_v2/api/country.dart';

class CountryRepository {
  final CountryProvider _countryRepository = CountryProvider();

  Future<List<Country>> getAllCountry() => _countryRepository.getCountry();
}
