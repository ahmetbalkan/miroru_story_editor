import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

class DecorationDeleteWidget extends HookWidget {
  const DecorationDeleteWidget({
    super.key,
    required this.nearDeleteArea,
  });

  final bool nearDeleteArea;

  @override
  Widget build(BuildContext context) {
    final scale = nearDeleteArea ? 1.2 : 1.0;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.fromBorderSide(
            BorderSide(
              color: nearDeleteArea ? Colors.red : Colors.white,
              width: 2,
            ),
          ),
        ),
        child: Icon(
          Ionicons.trash,
          color: nearDeleteArea ? Colors.red : Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
