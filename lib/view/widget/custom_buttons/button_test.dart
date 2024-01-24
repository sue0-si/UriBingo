import 'package:flutter/material.dart';

import 'first_custom_button.dart';

class ButtonTest extends StatelessWidget {
  const ButtonTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: NiceButtons(onTap: (){}, child: Container(),),),
    );
  }
}
