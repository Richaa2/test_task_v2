import 'package:flutter/material.dart';

class ContainerForFlag extends StatelessWidget {
  const ContainerForFlag({
    Key? key,
    required this.flag,
  }) : super(key: key);

  final String flag;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 20,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(flag)),
      ),
    );
  }
}
