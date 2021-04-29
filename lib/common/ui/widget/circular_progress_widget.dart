import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
