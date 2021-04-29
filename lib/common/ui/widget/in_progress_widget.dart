import 'package:askimam/common/ui/widget/circular_progress_widget.dart';
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
        if (isInProgress) const Center(child: CircularProgressWidget()),
      ],
    );
  }
}
