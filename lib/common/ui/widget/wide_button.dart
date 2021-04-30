import 'package:askimam/common/ui/widget/circular_progress.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final VoidCallback _onPressed;
  final bool isInProgress;

  const WideButton(
    this._title,
    this._icon,
    this._onPressed, {
    Key? key,
    this.isInProgress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _onPressed,
        icon: isInProgress
            ? const CircularProgress(size: CircularProgressSize.small)
            : Icon(_icon),
        label: Text(_title),
      ),
    );
  }
}
