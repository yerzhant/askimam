import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final VoidCallback _onPressed;

  const WideButton(
    this._title,
    this._icon,
    this._onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _onPressed,
      icon: Icon(_icon),
      label: Text(_title),
    );
  }
}
