import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final bool isInButton;

  const CircularProgress({
    Key? key,
    this.isInButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _externalSize,
      height: _externalSize,
      child: Center(
        child: SizedBox(
          width: _internalSize,
          height: _internalSize,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
            backgroundColor: isInButton ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}

const _externalSize = 24.0;
const _internalSize = 16.0;
