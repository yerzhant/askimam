import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final CircularProgressSize size;

  const CircularProgress({
    Key? key,
    this.size = CircularProgressSize.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: _externalSize,
      height: _externalSize,
      child: Center(
        child: SizedBox(
          width: _internalSize,
          height: _internalSize,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

enum CircularProgressSize { small, normal }

const _externalSize = 24.0;
const _internalSize = 16.0;
