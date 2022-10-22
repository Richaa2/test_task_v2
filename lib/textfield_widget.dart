import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_v2/api/bloc/country_bloc.dart';

import 'country.dart';
import 'main_screen.dart';

class TextFieldWidget extends StatefulWidget {
  final List<Country> countries;

  TextFieldWidget({
    Key? key,
    required this.countries,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  static String hintVal = '(123)123-1234';
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller2.text = hintVal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(244, 245, 255, 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Stack(
          children: [
            IgnorePointer(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: controller2,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(13),
              ],
              controller: controller,
              onChanged: inputNumber,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  void inputNumber(String query) {
    if (controller.text.isNotEmpty) {
      setState(() {
        //записати в одну переміну
        if (controller.text.length < 13 &&
            controller.text.endsWith('(') != true &&
            controller.text.endsWith(')') != true &&
            controller.text.endsWith('-') != true) {
          if (controller.text.length == 1) {
            controller.text = query.replaceRange(0, 1, '(') + query;
          }

          if (controller.text.length == 5) {
            controller.text =
                query.replaceRange(4, 5, ')${query.characters.last}');
          }

          if (controller.text.length == 9) {
            controller.text =
                query.replaceRange(8, 9, '-${query.characters.last}');
          }
        }

        controller.selection =
            TextSelection.collapsed(offset: controller.text.length);
      });
      if (controller.text.length == 13) {
        b = true;
        BlocProvider.of<CountryBloc>(context)
            .add(CountryFillEvent(widget.countries));
      } else {
        b = false;
        BlocProvider.of<CountryBloc>(context)
            .add(CountryFillEvent(widget.countries));
      }
    }
    String newHint = "";
    for (int i = 0; i < hintVal.length; i++) {
      if (i < query.length) {
        newHint += query[i];
      } else {
        newHint += hintVal[i];
      }
    }

    controller2.text = newHint;
  }
}
