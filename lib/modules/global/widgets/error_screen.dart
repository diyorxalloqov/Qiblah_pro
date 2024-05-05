import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NoNetworkScreen extends StatelessWidget {
  final VoidCallback onTap;
  const NoNetworkScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.no_network, width: 181, height: 181),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text(
                'noNetwork'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontWeight: AppFontWeight.w_700,
                    fontSize: AppSizes.size_16),
              ),
            ),
            SizedBox(height: 7.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Text('noNetwork1'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontSize: AppSizes.size_12,
                      fontWeight: FontWeight.w300)),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 14.w, vertical: context.bottom / 9 + 50),
          child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  )),
              child: Center(
                child: Text(
                  'retry'.tr(),
                  style: TextStyle(
                      fontFamily: AppfontFamily.inter.fontFamily,
                      fontWeight: AppFontWeight.w_600,
                      color: Colors.white,
                      fontSize: AppSizes.size_16),
                ),
              )),
        ),
      ],
    );
  }
}
