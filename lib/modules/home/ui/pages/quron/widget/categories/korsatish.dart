import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class Korsatish extends StatefulWidget {
  const Korsatish({super.key});

  @override
  State<Korsatish> createState() => _EkranState();
}

class _EkranState extends State<Korsatish> {
  bool isArabcha = false;
  bool oqilishi = false;
  bool manosi = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      color:  context.isDark
                ? homeBlackMainColor
                : bottomSheetBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'korsatish'.tr(),
            style: TextStyle(
                fontSize: AppSizes.size_18,
                fontFamily: AppfontFamily.inter.fontFamily,
                fontWeight: AppFontWeight.w_400,
                color: primaryColor),
          ),
          const SpaceHeight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'qorongu_mavzu'.tr(),
                style: TextStyle(
                  fontSize: AppSizes.size_16,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontWeight: AppFontWeight.w_400,
                ),
              ),
              Switch.adaptive(
                  value: isArabcha,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.white,
                  onChanged: (v) {
                    isArabcha = v;
                    setState(() {});
                  })
            ],
          ),
          const SpaceHeight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'oqilishi'.tr(),
                style: TextStyle(
                  fontSize: AppSizes.size_16,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontWeight: AppFontWeight.w_400,
                ),
              ),
              Switch.adaptive(
                  value: oqilishi,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.white,
                  onChanged: (v) {
                    oqilishi = v;
                    setState(() {});
                  })
            ],
          ),
          const SpaceHeight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'manolar_tarjimasi'.tr(),
                style: TextStyle(
                  fontSize: AppSizes.size_16,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontWeight: AppFontWeight.w_400,
                ),
              ),
              Switch.adaptive(
                  value: manosi,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.white,
                  onChanged: (v) {
                    manosi = v;
                    setState(() {});
                  })
            ],
          ),
        ],
      ),
    );
  }
}
