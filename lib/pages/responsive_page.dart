import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;
  const ResponsivePage({super.key, required this.mobileLayout, required this.desktopLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth > 400) {
        return desktopLayout;
      }

      return mobileLayout;
    });
  }
}
