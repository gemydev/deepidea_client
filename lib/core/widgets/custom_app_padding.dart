import 'package:flutter/material.dart';

class CustomAppPadding extends StatelessWidget {
  const CustomAppPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
      child: child,
    ));
  }
}
