import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Loading extends StatefulWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration:const Duration(seconds: 1))..repeat();
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AnimatedBuilder(
         animation: _controller,
         builder: (_, child) {
           return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: child,
           );
         },
          child: const Icon(Ionicons.remove_outline),
      ),
    );
  }
}