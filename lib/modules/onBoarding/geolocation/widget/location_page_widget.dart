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
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xffE2F5DE),
          Color(0xffDEF2E5),
          Color(0xffECFAE1),
        ],
      )),
      child: Column(
        children: [
          Center(child: Image.asset(AppImages.location)),
          Container(
            constraints: BoxConstraints(
                maxWidth: context.width,
                minWidth: context.width,
                maxHeight: 530.h,
                minHeight: 400.h),
            padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 30.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
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
                SpaceHeight(height: 30.h),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox.fromSize(),
                    TextButton(
                        onPressed: textButtonOnTap,
                        child: Text(
                          'qolda_sozlayman'.tr(),
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: AppSizes.size_16,
                              fontWeight: AppFontWeight.w_600),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
