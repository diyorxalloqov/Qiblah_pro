import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class LocationPageWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget elevatedButtonShow;
  final VoidCallback textButtonOnTap;
  const LocationPageWidget(
      {super.key,
      required this.onTap,
      required this.elevatedButtonShow,
      required this.textButtonOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: context.isDark ? Alignment.topRight : Alignment.centerLeft,
              end:
                  context.isDark ? Alignment.bottomLeft : Alignment.bottomRight,
              colors: context.isDark ? onBoardingBlack : onBoardingColor)),
      child: Column(
        children: [
          Center(child: Image.asset(AppImages.location)),
          const Spacer(),
          Column(
            children: [
              Container(
                height: 440.h,
                padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 30.h),
                decoration: BoxDecoration(
                    color: context.isDark
                        ? bottomSheetBackgroundBlackColor
                        : bottomSheetBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HighText(text: 'joylashuv'.tr()),
                    const SpaceHeight(),
                    Text('joylashuv_promt'.tr(),
                        style: AppfontFamily.inter.copyWith(
                            color: smallTextColor,
                            fontSize: AppSizes.size_15,
                            fontWeight: AppFontWeight.w_400)),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            fixedSize: Size(double.infinity, 50.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r))),
                        child: elevatedButtonShow),
                    const SpaceHeight(),
                    Center(
                      child: TextButton(
                          onPressed: textButtonOnTap,
                          child: Text(
                            'qolda_sozlayman'.tr(),
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: AppSizes.size_16,
                                fontWeight: AppFontWeight.w_600),
                          )),
                    ),
                    SpaceHeight(height: context.bottom + 10)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
