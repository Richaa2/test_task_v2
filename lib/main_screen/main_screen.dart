// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task_v2/api/bloc/country_bloc.dart';
import 'package:test_task_v2/api/country.dart';
import 'package:test_task_v2/container_for_flag.dart';
import 'package:test_task_v2/main_screen/textfield_widget.dart';

import '../search_screen/country_code_screen.dart';

bool filledField = false;

class MainScreen extends StatefulWidget {
  final String? imageOfCountry;
  final String? callingCode;
  const MainScreen({super.key, this.imageOfCountry, this.callingCode});

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CountryLoadedState) {
            List<Country> countries = state.loadedCountries;

            return _mainColumn([
              _buildGetStarted(),
              const Spacer(),
              _buldContainers(
                context,
                countries,
              ),
              const Spacer(),
              _buildButton(filledField),
            ]);
          }
          return Container();
        },
      ),
    );
  }

  Row _buildButton(bool filledField) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: filledField
                    ? Colors.white
                    : const Color.fromRGBO(244, 245, 255, 0.4)),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward),
              color: const Color(0xff7886B8),
              onPressed: () => filledField
                  ? print('Number approved')
                  : print('plese fill the field'),
            )),
      ],
    );
  }

  Padding _mainColumn(List<Widget> children) {
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
  ) {
    return Row(
      children: [
        InkWell(
          onTap: () => showModalBottomSheetMetod(
              context,
              CountryCodeScreen(
                listOfCountries: countries,
              )),
          child: _buildCountryContainer(),
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

  Container _buildCountryContainer() {
    return Container(
        width: 71,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(244, 245, 255, 0.4)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ContainerForFlag(flag: widget.imageOfCountry!),
          Text('+${widget.callingCode}')
        ]));
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
      backgroundColor: const Color(0xff8EAAFB),
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
