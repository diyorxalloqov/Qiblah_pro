import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

PreferredSizeWidget customAppbar(BuildContext context, String title,
    {String? icon1,
    VoidCallback? onTap1,
    String? icon2,
    Widget? icon3,
    VoidCallback? onTap2}) {
  return AppBar(
    scrolledUnderElevation: 0,
    leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          width: 28,
          height: 28,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: SvgPicture.asset(AppIcon.arrowLeft,
              color: context.isDark ? const Color(0xffB5B9BC) : null),
        )),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          fontFamily: AppfontFamily.comforta.fontFamily,
          fontWeight: AppFontWeight.w_700,
          fontSize: AppSizes.size_18),
    ),
    actions: [
      icon1 != null
          ? IconButton(
              onPressed: onTap1,
              icon: SvgPicture.asset(icon1,
                  color: context.isDark ? Colors.white : null))
          : const SizedBox.shrink(),
      icon2 != null
          ? IconButton(
              onPressed: onTap2,
              icon: SvgPicture.asset(icon2,
                  color: context.isDark ? Colors.white : null))
          : const SizedBox.shrink(),
      icon3 ?? const SizedBox.shrink(),
    ],
  );
}
