import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamozPage extends StatelessWidget {
  const NamozPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title: MediumText(text: 'organish'.tr()),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r))),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'learnNamozPage');
                },
                child: Container(
                  height: 120.h,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                  decoration: BoxDecoration(
                      color: context.isDark
                          ? containerBlackColor
                          : const Color(0xFFF4EBD8),
                      borderRadius: BorderRadius.circular(16.r),
                      image: const DecorationImage(
                          image: AssetImage(AppImages.joynamoz),
                          alignment: Alignment.centerRight)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "namoz_oqishni_organish".tr(),
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(
                            color: context.isDark
                                ? Colors.white
                                : const Color(0xFF615745),
                            fontFamily: AppfontFamily.comforta.fontFamily,
                            fontSize: AppSizes.size_16,
                            fontWeight: AppFontWeight.w_700,
                          ),
                        ),
                      ),
                      const SpaceHeight(),
                      const SmallText(text: 'Lorem Ipsum is simply dummy')
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 120.h,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                  decoration: BoxDecoration(
                      color: context.isDark
                          ? containerBlackColor
                          : const Color(0xFFD0EAF8),
                      borderRadius: BorderRadius.circular(16.r),
                      image: const DecorationImage(
                          image: AssetImage(AppImages.tahorat),
                          alignment: Alignment.centerRight)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "tahorat_olishni_organish".tr(),
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(
                            color: context.isDark
                                ? Colors.white
                                : const Color(0xFF615745),
                            fontFamily: AppfontFamily.comforta.fontFamily,
                            fontSize: AppSizes.size_16,
                            fontWeight: AppFontWeight.w_700,
                          ),
                        ),
                      ),
                      const SpaceHeight(),
                      const SmallText(text: 'Lorem Ipsum is simply dummy')
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 141.h,
                      width: 170.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      decoration: BoxDecoration(
                          color: context.isDark
                              ? containerBlackColor
                              : const Color(0xFFFDE3E3),
                          borderRadius: BorderRadius.circular(16.r),
                          image: const DecorationImage(
                              image: AssetImage(AppImages.mistake),
                              alignment: Alignment.bottomRight)),
                      child: Text(
                        "namozdagi_hatoliklar".tr(),
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: TextStyle(
                          color: context.isDark
                              ? Colors.white
                              : const Color(0xFF615745),
                          fontFamily: AppfontFamily.comforta.fontFamily,
                          fontSize: AppSizes.size_16,
                          fontWeight: AppFontWeight.w_700,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 141.h,
                      width: 170.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      decoration: BoxDecoration(
                          color: context.isDark
                              ? containerBlackColor
                              : const Color(0xFFF5E5E0),
                          borderRadius: BorderRadius.circular(16.r),
                          image: const DecorationImage(
                              image: AssetImage(AppImages.book),
                              alignment: Alignment.bottomRight)),
                      child: Text(
                        "qoshimchalar".tr(),
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: TextStyle(
                          color: context.isDark
                              ? Colors.white
                              : const Color(0xFF615745),
                          fontFamily: AppfontFamily.comforta.fontFamily,
                          fontSize: AppSizes.size_16,
                          fontWeight: AppFontWeight.w_700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 141.h,
                  width: 170.w,
                  margin: const EdgeInsets.only(top: 12),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                  decoration: BoxDecoration(
                      color: context.isDark
                          ? containerBlackColor
                          : const Color(0xFFF7EFEB),
                      borderRadius: BorderRadius.circular(16.r),
                      image: const DecorationImage(
                          image: AssetImage(AppImages.jamoat),
                          alignment: Alignment.bottomRight)),
                  child: Text(
                    "jamoat_namozi".tr(),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: TextStyle(
                      color: context.isDark
                          ? Colors.white
                          : const Color(0xFF615745),
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontSize: AppSizes.size_16,
                      fontWeight: AppFontWeight.w_700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
