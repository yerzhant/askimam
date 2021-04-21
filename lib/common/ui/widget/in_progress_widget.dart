import 'package:flutter/material.dart';

class InProgressWidget extends StatelessWidget {
  final Widget child;

  const InProgressWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const CircularProgressIndicator(),
      ],
    );
  }
}
