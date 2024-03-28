import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.0.h),
      margin: EdgeInsets.only(top: 18.h, right: 12.w),
      decoration: BoxDecoration(
          color: context.isDark ? homeBlackMainColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'kun_oyati'.tr(),
                style: TextStyle(
                    fontSize: AppSizes.size_12,
                    color: primaryColor,
                    fontFamily: AppfontFamily.inter.fontFamily,
                    fontWeight: AppFontWeight.w_600),
              ),
              Text(
                'Al-Baqara (16:43)',
                style: TextStyle(
                    fontSize: AppSizes.size_12,
                    color: primaryColor,
                    fontFamily: AppfontFamily.inter.fontFamily,
                    fontWeight: AppFontWeight.w_400),
              ),
            ],
          ),
          SpaceHeight(height: 18.h),
          Text(
            'Poklar poklar uchundir!',
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(
                fontSize: AppSizes.size_20,
                fontFamily: AppfontFamily.comforta.fontFamily,
                fontWeight: AppFontWeight.w_700,
                color: context.isDark ? mediumTextWhiteColor : mediumTextColor),
          ),
          SpaceHeight(height: 10.h),
          Text(
            'Ushbu oyatni ko’pchilik shunchaki instaga yozib qo’yishadi.. Balki nopokligini bilsada, o’zining nopokini izlashar balki',
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
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
                onTap: () {},
                radius: 16.r,
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: context.isDark
                      ? circleAvatarBlackColor
                      : circleAvatarColor,
                  child: Center(
                    child: SvgPicture.asset(AppIcon.bookmark,
                        color: context.isDark ? const Color(0xffB5B9BC) : null),
                  ),
                ),
              ),
              SpaceWidth(width: 18.w),
              InkWell(
                onTap: () {},
                radius: 16.r,
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: context.isDark
                      ? circleAvatarBlackColor
                      : circleAvatarColor,
                  child: Center(
                    child: SvgPicture.asset(AppIcon.share,
                        color: context.isDark ? const Color(0xffB5B9BC) : null),
                  ),
                ),
              ),
              SpaceWidth(width: 18.w),
              InkWell(
                onTap: () {},
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
    );
  }
}
