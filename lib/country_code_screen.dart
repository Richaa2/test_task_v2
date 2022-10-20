import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task_v2/country.dart';
import 'package:test_task_v2/textfield_widget.dart';

class CountryCodeScreen extends StatelessWidget {
  const CountryCodeScreen({
    Key? key,
    required this.listOfCountries,
  }) : super(key: key);

  final List<Country> listOfCountries;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 752,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          _buildTitle(context),
          TextFieldWidget(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print(listOfCountries[index].flag);
                return Row(
                  children: [
                    Container(
                      width: 30,
                      height: 20,
                      child: SvgPicture.network(listOfCountries[index].flag),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
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
}
