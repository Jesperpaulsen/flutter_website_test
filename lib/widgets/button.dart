import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  Button(this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              label,
              style: TextStyle(fontSize: 14),
            )),
      ),
    );
  }
}
