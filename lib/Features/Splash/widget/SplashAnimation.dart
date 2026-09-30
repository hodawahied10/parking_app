import 'package:flutter/material.dart';

import 'package:parkingapp/Core/Theme/AppAssets.dart';

class Splashanimation extends StatelessWidget {
  const Splashanimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        Appassets.backgroundImage,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
