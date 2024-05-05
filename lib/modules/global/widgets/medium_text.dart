import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class MediumText extends StatelessWidget {
  final String text;
  const MediumText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
          fontSize: AppSizes.size_18,
          fontFamily: AppfontFamily.comforta.fontFamily,
          fontWeight: AppFontWeight.w_700,
          color: context.isDark ? mediumTextWhiteColor : mediumTextColor),
    );
  }
}
