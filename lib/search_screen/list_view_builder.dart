import 'package:flutter/material.dart';
import 'package:test_task_v2/api/country.dart';
import 'package:test_task_v2/container_for_flag.dart';
import 'package:test_task_v2/main_screen/main_screen.dart';

class ListViewBuilderWidget extends StatelessWidget {
  const ListViewBuilderWidget({
    Key? key,
    required this.listForSearch,
  }) : super(key: key);

  final List<Country> listForSearch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listForSearch.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(
                    imageOfCountry: listForSearch[index].flags,
                    callingCode: listForSearch[index].callingCodes[0],
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ContainerForFlag(flag: listForSearch[index].flags),
                  sizedBox(),
                  _buildCallingCode(index),
                  sizedBox(),
                  _buildName(index),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded _buildName(int index) {
    return Expanded(
      child: Text(
        listForSearch[index].name,
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
      ),
    );
  }

  Text _buildCallingCode(int index) {
    return Text(
      '+${listForSearch[index].callingCodes[0]}',
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
  }

  SizedBox sizedBox() {
    return const SizedBox(
      width: 10,
    );
  }
}
