import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task_v2/country.dart';
import 'package:test_task_v2/main_screen.dart';
import 'package:test_task_v2/textfield_widget.dart';

class CountryCodeScreen extends StatefulWidget {
  CountryCodeScreen({
    Key? key,
    required this.listOfCountries,
  }) : super(key: key);

  final List<Country> listOfCountries;
  late List<Country> listForSearch = listOfCountries;

  @override
  State<CountryCodeScreen> createState() => _CountryCodeScreenState();
}

class _CountryCodeScreenState extends State<CountryCodeScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 752,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(children: [
          _buildTitle(context),
          Container(
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: searchCountry,
            ),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(244, 245, 255, 0.4),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.listForSearch.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreen(
                                  imageOfCountry:
                                      widget.listForSearch[index].flags,
                                  callingCode: widget
                                      .listForSearch[index].callingCodes[0],
                                ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.listForSearch[index].flags)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '+' + widget.listForSearch[index].callingCodes[0],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.listForSearch[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ]),
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
    final suggestions = widget.listForSearch.where((country) {
      final countryName = country.name.toLowerCase();
      final input = query.toLowerCase();

      return countryName.contains(input);
    }).toList();

    setState(() {
      if (controller.text.isEmpty) {
        widget.listForSearch = widget.listOfCountries;
      } else {
        widget.listForSearch = suggestions;
      }
    });
  }
}
