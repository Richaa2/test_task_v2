import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task_v2/api/bloc/country_bloc.dart';
import 'package:test_task_v2/country.dart';
import 'package:test_task_v2/country_code_screen.dart';
import 'package:test_task_v2/textfield_widget.dart';

bool b = false;

class MainScreen extends StatefulWidget {
  final String imageOfCountry;
  final String callingCode;
  MainScreen(
      {super.key, required this.imageOfCountry, required this.callingCode});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CountryBloc, CountryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CountryInitialState) {
            BlocProvider.of<CountryBloc>(context).add(CountryLoadEvent());
          }
          if (state is CountryLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CountryLoadedState) {
            List<Country> countries = state.loadedCountries;
            return mainColumn([
              _buildGetStarted(),
              const Spacer(),
              _buldContainers(
                context,
                countries,
                b,
              ),
              const Spacer(),
              _buildButton(b),
            ]);
          }
          return Container();
        },
      ),
    );
  }

  Row _buildButton(bool b) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: b ? Colors.white : Color.fromRGBO(244, 245, 255, 0.4)),
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              color: Color(0xff7886B8),
              onPressed: () =>
                  b ? print('Number approved') : print('plese fill the field'),
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

  Row _buldContainers(
    BuildContext context,
    List<Country> countries,
    bool b,
  ) {
    return Row(
      children: [
        InkWell(
          onTap: () => showModalBottomSheetMetod(
              context,
              CountryCodeScreen(
                listOfCountries: countries,
              )),
          child: Container(
              width: 71,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromRGBO(244, 245, 255, 0.4)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 28,
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.imageOfCountry)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text('+' + widget.callingCode)
                  ])),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: TextFieldWidget(
          countries: countries,
        ))
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
