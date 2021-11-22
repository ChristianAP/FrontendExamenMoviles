import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController _controller;
  final String label;
  TextBox(this._controller, this.label);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        controller: this._controller,
        decoration: InputDecoration(
            filled: true,
            labelText: this.label,
            suffix: GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                _controller.clear();
              },
            )),
      ),
    );
  }
}
