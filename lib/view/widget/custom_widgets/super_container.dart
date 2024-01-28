import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';

class SuperContainer extends StatelessWidget {
  double height;
  double width;
  double border;
  double borderWidth;
  Color borderColor;
  Color? color;
  DecorationImage? image;

  SuperContainer({
    super.key,
    required this.height,
    required this.width,
    required this.border,
    required this.borderWidth,
    required this.borderColor,
    this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          width: width,
          decoration: ShapeDecoration(
            color: borderColor,
            shape: SquircleBorder(
              radius: BorderRadius.all(
                Radius.circular(border),
              ),
            ),
          ),
        ),
        Container(
          height: height - borderWidth,
          width: width - borderWidth,
          padding: EdgeInsets.all(borderWidth),
          decoration: ShapeDecoration(
            color: color,
            image: image,
            shape: SquircleBorder(
              radius: BorderRadius.all(
                Radius.circular(border - borderWidth),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
