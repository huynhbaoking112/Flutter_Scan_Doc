import 'package:flutter/material.dart';

class ChooseCamera extends StatelessWidget {
  const ChooseCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height - 240,
      ),
    );
  }
}
