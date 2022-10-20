import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_task_v2/country_code_screen.dart';
import 'package:test_task_v2/textfield_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainColumn([
        _buildGetStarted(),
        const Spacer(),
        _buldContainers(context),
        const Spacer(),
        _buildButton(),
      ]),
    );
  }

  Row _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(244, 245, 255, 0.4)),
            child: const Icon(
              Icons.arrow_forward,
              color: Color(0xff7886B8),
            )),
      ],
    );
  }

  Padding mainColumn(List<Widget> children) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20, top: 80, bottom: 20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Row _buldContainers(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => showModalBottomSheetMetod(context, CountryCodeScreen()),
          child: Container(
              width: 71,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromRGBO(244, 245, 255, 0.4))),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(child: TextFieldWidget())
      ],
    );
  }

  Text _buildGetStarted() {
    return const Text(
      'Get Started',
      style: TextStyle(
          color: Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 32),
    );
  }
}

Future<dynamic> showModalBottomSheetMetod(BuildContext context, Widget child) {
  return showModalBottomSheet(
      backgroundColor: Color(0xff8EAAFB),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      context: context,
      builder: (context) => SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: child));
}
