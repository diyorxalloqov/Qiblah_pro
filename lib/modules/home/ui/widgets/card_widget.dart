import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.height * 0.3,
          width: context.width * 0.85,
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
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
                        fontWeight: AppFontWeight.w_600),
                  ),
                  Text(
                    'Al-Baqara (16:43)',
                    style: TextStyle(
                        fontSize: AppSizes.size_12,
                        color: primaryColor,
                        fontWeight: AppFontWeight.w_600),
                  ),
                ],
              ),
              const SpaceHeight(),
              const MediumText(text: 'Poklar poklar uchundir!'),
              const SpaceHeight(),
              const SmallText(
                  text:
                      'Ushbu oyatni ko’pchilik shunchaki instaga yozib qo’yishadi.. Balki nopokligini bilsada, o’zining nopokini izlashar balki'),
              const SpaceHeight(),
              const SpaceHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    radius: 30.r,
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: circleAvatarColor,
                      child: Center(
                        child: SvgPicture.asset(AppIcon.bookmark),
                      ),
                    ),
                  ),
                  SpaceWidth(width: 18.w),
                  InkWell(
                    onTap: () {},
                    radius: 30.r,
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: circleAvatarColor,
                      child: Center(
                        child: SvgPicture.asset(AppIcon.share),
                      ),
                    ),
                  ),
                  SpaceWidth(width: 18.w),
                  InkWell(
                    onTap: () {},
                    radius: 30.r,
                    child: CircleAvatar(
                      radius: 30.r,
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
        const SpaceHeight(),
        const SpaceHeight()
      ],
    );
  }
}
