import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String _title;
  final IconData _icon;

  const WideButton(
    this._title,
    this._icon, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(_icon),
      label: Text(_title),
    );
  }
}
