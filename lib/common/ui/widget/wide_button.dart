import 'package:askimam/common/ui/widget/circular_progress.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String _title;
  final VoidCallback _onPressed;
  final bool isInProgress;

  const WideButton(
    this._title,
    this._onPressed, {
    Key? key,
    this.isInProgress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _onPressed,
        child: isInProgress
            ? const CircularProgress(isInButton: true)
            : Text(_title),
      ),
    );
  }
}
