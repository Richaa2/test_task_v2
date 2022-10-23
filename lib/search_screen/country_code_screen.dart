import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:test_task_v2/api/country.dart';
import 'package:test_task_v2/list_view_builder.dart';

class CountryCodeScreen extends StatefulWidget {
  const CountryCodeScreen({
    Key? key,
    required this.listOfCountries,
  }) : super(key: key);

  final List<Country> listOfCountries;

  @override
  State<CountryCodeScreen> createState() => _CountryCodeScreenState();
}

class _CountryCodeScreenState extends State<CountryCodeScreen> {
  late List<Country> listForSearch = widget.listOfCountries;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 752,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(children: [
          _buildTitle(context),
          _buildTextField(),
          ListViewBuilderWidget(listForSearch: listForSearch)
        ]),
      ),
    );
  }

  Container _buildTextField() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(244, 245, 255, 0.4),
      ),
      child: TextField(
        decoration: const InputDecoration(border: InputBorder.none),
        controller: controller,
        autofocus: true,
        onChanged: searchCountry,
      ),
    );
  }

  Row _buildTitle(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Country Code',
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.white, fontSize: 32),
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(244, 245, 255, 0.4),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              CupertinoIcons.clear_thick,
              size: 12,
              color: Color(0xff594C74),
            ),
          ),
        )
      ],
    );
  }

  void searchCountry(String query) {
    final suggestions = listForSearch.where((country) {
      final countryName = country.name.toLowerCase();
      final countryCode = country.callingCodes[0].toLowerCase();
      final input = query.toLowerCase();

      return countryName.contains(input) || countryCode.contains(input);
    }).toList();

    setState(() {
      if (controller.text.isEmpty) {
        listForSearch = widget.listOfCountries;
      } else {
        listForSearch = suggestions;
      }
    });
  }
}
