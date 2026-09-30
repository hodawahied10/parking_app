import 'package:flutter/material.dart';

class AppShadows {
  static const BoxShadow card = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  static const BoxShadow soft = BoxShadow(
    color: Color(0x12000000),
    blurRadius: 8,
    offset: Offset(0, 3),
  );
}
