import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';

class ButtonTest extends StatelessWidget {
  const ButtonTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NiceButtons(
          onTap: () {},
          child: Container(),
        ),
      ),
    );
  }
}
