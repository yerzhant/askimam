import 'package:flutter/material.dart';

class InProgressWidget extends StatelessWidget {
  final Widget child;
  final bool isInProgress;

  const InProgressWidget({
    Key? key,
    required this.child,
    this.isInProgress = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isInProgress)
          const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      ],
    );
  }
}
