//로딩바

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SuperLoadingBar extends StatelessWidget {
  List<Color> colors;
  double? strokeWidth;

  SuperLoadingBar({
    super.key,
    required this.colors,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      indicatorType: Indicator.ballClipRotateMultiple,
      colors: colors,
      strokeWidth: strokeWidth,
    );
  }
}
