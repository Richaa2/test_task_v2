import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_task_v2/api/country.dart';

class CountryProvider {
  Future<List<Country>> getCountry() async {
    const url =
        'https://restcountries.com/v2/all?fields=name,callingCodes,flags';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Country> contriesList = [];
      final List countries = json.decode(response.body);

      for (var element in countries) {
        contriesList.add(Country.fromMap(element));
      }

      return contriesList;
    } else {
      throw Exception('Error ${response.reasonPhrase}');
    }
  }
}
