import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/premium/presentation/ui/in_app_purchase_example.dart';
import 'package:qiblah_pro/modules/premium/presentation/widgets/help_dialog.dart';

class PremiumScreen extends StatefulWidget {
  final bool isOnboarding;
  const PremiumScreen({super.key, required this.isOnboarding});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool isFirstContainerSelected = true;
  bool isSecondContainerSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: SweepGradient(
                colors:
                    context.isDark ? profileBlackGradient : profileGradient),
            image: DecorationImage(
                image: AssetImage(context.isDark
                    ? AppImages.premium_back_black
                    : AppImages.premium_back),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Image.asset(AppImages.premium,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        width: 245),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) => const HelpDialog());
                          },
                          child: SvgPicture.asset(AppIcon.info, width: 24)),
                      SizedBox(width: 8.w),
                      GestureDetector(
                          onTap: () {
                            widget.isOnboarding
                                ? Navigator.pushNamedAndRemoveUntil(
                                    context, 'homePage', (route) => false)
                                : Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                              context.isDark
                                  ? AppIcon.cancelBlack
                                  : AppIcon.cancel,
                              width: 24)),
                      SizedBox(width: 12.w)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 35.h),
              Center(
                child: Text(
                  'premium_bilan'.tr(),
                  style: TextStyle(
                    color: primaryColor,
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontSize: AppSizes.size_20,
                    fontWeight: AppFontWeight.w_700,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  'premium_imkoniyat'.tr(),
                  style: TextStyle(
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontSize: AppSizes.size_20,
                    fontWeight: AppFontWeight.w_700,
                  ),
                ),
              ),
              SpaceHeight(height: 18.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: context.isDark
                                ? const Color(0xff232C37)
                                : primaryColor.withOpacity(0.2),
                            radius: 14.r,
                            child: Icon(Icons.check,
                                color: primaryColor, size: 15.w)),
                        SizedBox(width: 12.w),
                        Text(
                          "premium_ficha_1".tr(),
                          style: AppfontFamily.inter.copyWith(
                            fontSize: AppSizes.size_15,
                            color: context.isDark ? Colors.white : Colors.black,
                            fontWeight: AppFontWeight.w_500,
                          ),
                        ),
                      ],
                    ),
                    SpaceHeight(height: 20.h),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: context.isDark
                              ? const Color(0xff232C37)
                              : primaryColor.withOpacity(0.2),
                          radius: 14.r,
                          child: Icon(Icons.check,
                              color: primaryColor, size: 15.w),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          "premium_ficha_2".tr(),
                          style: AppfontFamily.inter.copyWith(
                              fontSize: AppSizes.size_15,
                              color:
                                  context.isDark ? Colors.white : Colors.black,
                              fontWeight: AppFontWeight.w_500),
                        ),
                      ],
                    ),
                    SpaceHeight(height: 20.h),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: context.isDark
                              ? const Color(0xff232C37)
                              : primaryColor.withOpacity(0.2),
                          radius: 14.r,
                          child: Icon(Icons.check,
                              color: primaryColor, size: 15.w),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          "premium_ficha_3".tr(),
                          style: AppfontFamily.inter.copyWith(
                            fontSize: AppSizes.size_15,
                            color: context.isDark ? Colors.white : Colors.black,
                            fontWeight: AppFontWeight.w_500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'premium_imkoniyat1'.tr(),
                      style: TextStyle(
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontSize: AppSizes.size_12,
                          fontWeight: AppFontWeight.w_400),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirstContainerSelected = true;
                          isSecondContainerSelected = false;
                        });
                      },
                      child: Container(
                        height: 69.h,
                        margin: EdgeInsets.symmetric(vertical: 17.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: isFirstContainerSelected
                                ? Border.all(color: primaryColor, width: 1)
                                : Border.all(
                                    width: 1,
                                    color: context.isDark
                                        ? Colors.transparent
                                        : Colors.white),
                            borderRadius: BorderRadius.circular(12.r),
                            gradient: LinearGradient(
                                colors: context.isDark
                                    ? premiumBlackGradient
                                    : premiumGradient)),
                        child: Center(
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            leading: Container(
                              margin: const EdgeInsets.only(left: 5),
                              height: 26.r,
                              width: 26.r,
                              padding: const EdgeInsets.all(4),
                              decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(
                                      side: BorderSide(
                                          width: 0.5,
                                          color: Colors.grey.shade400))),
                              child: Container(
                                height: 18.r,
                                width: 18.r,
                                decoration: ShapeDecoration(
                                    color: isFirstContainerSelected
                                        ? primaryColor
                                        : Colors.white,
                                    shape: const OvalBorder()),
                              ),
                            ),
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'yillik'.tr(),
                                  style: TextStyle(
                                      fontFamily:
                                          AppfontFamily.comforta.fontFamily,
                                      fontSize: AppSizes.size_16,
                                      fontWeight: AppFontWeight.w_700,
                                      color: context.isDark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: primaryColor, width: 1),
                                      borderRadius:
                                          BorderRadius.circular(100.r)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: Text(
                                    "tavsiya_etamiz".tr(),
                                    style: TextStyle(
                                        fontFamily:
                                            AppfontFamily.comforta.fontFamily,
                                        fontSize: AppSizes.size_10,
                                        fontWeight: AppFontWeight.w_500,
                                        color: context.isDark
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${'oyiga'.tr()} - \$1.2",
                                  style: TextStyle(
                                      color: context.isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily:
                                          AppfontFamily.inter.fontFamily,
                                      fontSize: AppSizes.size_12,
                                      fontWeight: AppFontWeight.w_500),
                                ),
                                SizedBox(width: 9.w),
                                Text(
                                  "${'yiliga'.tr()} \$1.2 ${'tolaganda'.tr()}",
                                  style: TextStyle(
                                      color: const Color(0xff6D7379),
                                      fontFamily:
                                          AppfontFamily.inter.fontFamily,
                                      fontSize: AppSizes.size_12,
                                      fontWeight: AppFontWeight.w_500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirstContainerSelected = false;
                          isSecondContainerSelected = true;
                        });
                      },
                      child: Container(
                        height: 69.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: isSecondContainerSelected
                                ? Border.all(color: primaryColor, width: 1)
                                : Border.all(
                                    width: 1,
                                    color: context.isDark
                                        ? Colors.transparent
                                        : Colors.white),
                            gradient: LinearGradient(
                                colors: context.isDark
                                    ? premiumBlackGradient
                                    : premiumGradient)),
                        child: Center(
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            leading: Container(
                              margin: const EdgeInsets.only(left: 5),
                              height: 26.r,
                              width: 26.r,
                              padding: const EdgeInsets.all(4),
                              decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(
                                      side: BorderSide(
                                          width: 0.5,
                                          color: Colors.grey.shade400))),
                              child: Container(
                                height: 18.r,
                                width: 18.r,
                                decoration: ShapeDecoration(
                                    color: isSecondContainerSelected
                                        ? primaryColor
                                        : Colors.white,
                                    shape: const OvalBorder()),
                              ),
                            ),
                            title: Text(
                              'oylik'.tr(),
                              style: TextStyle(
                                  fontFamily: AppfontFamily.comforta.fontFamily,
                                  fontSize: AppSizes.size_16,
                                  fontWeight: AppFontWeight.w_700,
                                  color: context.isDark
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              "${'oyiga'.tr()} \$1.2",
                              style: TextStyle(
                                  color: context.isDark
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: AppfontFamily.inter.fontFamily,
                                  fontSize: AppSizes.size_12,
                                  fontWeight: AppFontWeight.w_500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                        fixedSize: Size(double.infinity, 48.h)),
                    child: Center(
                      child: Text(
                        'faollashtirish'.tr(),
                        style: TextStyle(
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: AppFontWeight.w_600,
                            fontSize: AppSizes.size_16,
                            color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }
}
