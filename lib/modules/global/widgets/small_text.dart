import 'package:flutter/widgets.dart';
import 'package:qiblah_pro/core/constants/app_colors.dart';

class SmallText extends StatelessWidget {
  final String text;
  const SmallText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: greyColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
