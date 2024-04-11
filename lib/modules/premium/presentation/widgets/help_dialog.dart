import 'package:qiblah_pro/core/constants/app/app_contact_urls.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/global/widgets/url_launcher.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: context.isDark ? const Color(0xff1E2125) : Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.help, width: 216.w, height: 116.h),
          Text(
            "muammo_bormi".tr(),
            style: TextStyle(
                fontFamily: AppfontFamily.comforta.fontFamily,
                fontWeight: AppFontWeight.w_700,
                color: context.isDark ? Colors.white : Colors.black,
                fontSize: AppSizes.size_20),
          ),
          SizedBox(height: 17.h),
          Text("muammo_bormi_promt".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: smallTextColor,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontSize: AppSizes.size_14,
                  fontWeight: AppFontWeight.w_400)),
          SizedBox(height: 10.h),
          Text("uzb_payment".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color.fromARGB(255, 76, 80, 79),
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontSize: AppSizes.size_14,
                  fontWeight: AppFontWeight.w_600)),
          SizedBox(height: 17.h),
          ElevatedButton(
              onPressed: () => urlLauncher(AppContactUrls.telegramUrl),
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  fixedSize: Size(double.infinity, 44.h)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcon.telegram_green),
                    SizedBox(width: 10.w),
                    Text("telegram_orqali".tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontSize: AppSizes.size_14,
                            fontWeight: AppFontWeight.w_600)),
                  ],
                ),
              )),
          SizedBox(height: 5.h),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'muammo_yoq'.tr(),
                style: TextStyle(
                    color: context.isDark ? Colors.white : Colors.black,
                    fontFamily: AppfontFamily.inter.fontFamily,
                    fontSize: AppSizes.size_14,
                    fontWeight: AppFontWeight.w_600),
              ))
        ],
      ),
    );
  }
}
