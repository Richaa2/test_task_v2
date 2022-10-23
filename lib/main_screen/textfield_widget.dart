import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_v2/api/bloc/country_bloc.dart';

import '../api/country.dart';
import 'main_screen.dart';

class TextFieldWidget extends StatefulWidget {
  final List<Country> countries;

  const TextFieldWidget({
    Key? key,
    required this.countries,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  static String hintVal = '(123)123-1234';
  TextEditingController controllerForBackground = TextEditingController();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerForBackground.text = hintVal;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContainer([
      _ignorePointer(),
      _textField(),
    ]);
  }

  Container _buildContainer(List<Widget> children) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(244, 245, 255, 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Stack(
          children: [
            _ignorePointer(),
            _textField(),
          ],
        ),
      ),
    );
  }

  IgnorePointer _ignorePointer() {
    return IgnorePointer(
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        controller: controllerForBackground,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  TextField _textField() {
    return TextField(
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
    );
  }

  void inputNumber(String query) {
    if (controller.text.isNotEmpty) {
      setState(() {
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
        filledField = true;
        BlocProvider.of<CountryBloc>(context)
            .add(CountryFillEvent(widget.countries));
      }
      if (filledField == true && controller.text.length != 13) {
        filledField = false;
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

    controllerForBackground.text = newHint;
  }
}
