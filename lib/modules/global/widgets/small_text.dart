import 'package:qiblah_pro/core/constants/app_fontfamily.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SmallText extends StatelessWidget {
  final String text;
  const SmallText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
        fontSize: AppSizes.size_14,
        color: smallTextColor,
        fontFamily: AppfontFamily.inter.fontFamily,
        fontWeight: AppFontWeight.w_500,
      ),
    );
  }
}
