
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)),
        child: const CircularProgressIndicator());
  }
}
