import 'dart:math';

import 'package:flutter/material.dart';

class ShakeError extends StatefulWidget {
  const ShakeError({
    Key? key,
    required this.child,
    required this.shakeCount,
    required this.shakeOffset,
    required this.animationController,
  }) : super(key: key);

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final AnimationController animationController;
  @override
  State<ShakeError> createState() => _ShakeErrorState();
}

class _ShakeErrorState extends State<ShakeError> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue = sin(widget.shakeCount * 2 * pi * widget.animationController.value);
        return Transform.translate(offset: Offset(sineValue * widget.shakeOffset, 0), child: child);
      },
    );
  }
}
