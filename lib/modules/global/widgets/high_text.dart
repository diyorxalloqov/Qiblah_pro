import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class HighText extends StatelessWidget {
  final String text;
  const HighText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: AppfontFamily.comforta.fontFamily,
          fontSize: he(AppSizes.size_28),
          fontWeight: AppFontWeight.w_700,
          color: context.isDark ? highTextWhiteColor : highTextColor),
    );
  }
}
