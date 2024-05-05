import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class CardWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isZikr;
  final String lentaName;
  final String zikrNumber;
  final String name;
  final String description;
  final TextDirection? textDirection;
  const CardWidget(
      {super.key,
      required this.lentaName,
      required this.zikrNumber,
      required this.name,
      this.textDirection,
      required this.description,
      required this.isZikr,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.0.h),
        margin: EdgeInsets.only(bottom: 18.h, right: 12.w),
        decoration: BoxDecoration(
            color: context.isDark ? homeBlackMainColor : Colors.white,
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lentaName,
                  style: TextStyle(
                      fontSize: AppSizes.size_12,
                      color: primaryColor,
                      fontFamily: AppfontFamily.inter.fontFamily,
                      fontWeight: AppFontWeight.w_600),
                ),
                isZikr
                    ? Text(
                        zikrNumber,
                        style: TextStyle(
                            fontSize: AppSizes.size_12,
                            color: primaryColor,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: AppFontWeight.w_400),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            SpaceHeight(height: 18.h),
            Text(
              name,
              style: TextStyle(
                  fontSize: AppSizes.size_20,
                  fontFamily: AppfontFamily.comforta.fontFamily,
                  fontWeight: AppFontWeight.w_700,
                  color:
                      context.isDark ? mediumTextWhiteColor : mediumTextColor),
            ),
            SpaceHeight(height: 10.h),
            Text(
              description,
              textDirection: textDirection,
              style: TextStyle(
                  fontSize: AppSizes.size_16,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontWeight: AppFontWeight.w_400,
                  color: smallTextColor),
            ),
            const SpaceHeight(),
            const SpaceHeight(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  // onTap: () {},
                  radius: 16.r,
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: context.isDark
                        ? circleAvatarBlackColor
                        : circleAvatarColor,
                    child: Center(
                      child: SvgPicture.asset(AppIcon.bookmark,
                          color:
                              context.isDark ? const Color(0xffB5B9BC) : null),
                    ),
                  ),
                ),
                SpaceWidth(width: 18.w),
                InkWell(
                  // onTap: () {},
                  radius: 16.r,
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: context.isDark
                        ? circleAvatarBlackColor
                        : circleAvatarColor,
                    child: Center(
                      child: SvgPicture.asset(AppIcon.share,
                          color:
                              context.isDark ? const Color(0xffB5B9BC) : null),
                    ),
                  ),
                ),
                SpaceWidth(width: 18.w),
                InkWell(
                  // onTap: () {},
                  radius: 16.r,
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: primaryColor,
                    child: Center(
                      child: SvgPicture.asset(AppIcon.play),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
