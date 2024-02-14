import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Image.asset(AppImages.book),
            const SpaceHeight(),
            Text(
              "loading_prop".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: AppfontFamily.comforta.fontFamily,
                  fontWeight: AppFontWeight.w_700,
                  fontSize: AppSizes.size_16),
            ),
            const SpaceHeight(),
            SmallText(text: 'zumar_surasi'.tr()),
          ],
        ),
        CircularProgressIndicator.adaptive(
          valueColor:
              AlwaysStoppedAnimation<Color>(primaryColor.withOpacity(0.2)),
          strokeWidth: 13,
          strokeAlign: 2,
        )
      ],
    );
  }
}
