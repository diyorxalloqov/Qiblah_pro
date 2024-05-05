import 'package:flutter/material.dart';

Color hexToColor(String hexString) {
  // Remove the '#' character if it exists
  if (hexString.startsWith('#')) {
    hexString = hexString.substring(1);
  }

  // Parse the hex string to an integer
  int hexValue = int.parse(hexString, radix: 16);

  // Create a color from the integer value
  return Color(hexValue).withOpacity(1.0);
}
