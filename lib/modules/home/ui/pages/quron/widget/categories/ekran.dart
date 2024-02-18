import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class Ekran extends StatefulWidget {
  const Ekran({super.key});

  @override
  State<Ekran> createState() => _EkranState();
}

class _EkranState extends State<Ekran> {
  bool isDarkMode = false;
  double _quronValue = 0.0;
  double _matnValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      color: context.isDark ? homeBlackMainColor : bottomSheetBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'displey_sozlamalari'.tr(),
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
                  value: isDarkMode,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.white,
                  onChanged: (v) {
                    isDarkMode = v;
                    setState(() {});
                  })
            ],
          ),
          const SpaceHeight(),
          BlocBuilder<QuronBloc, QuronState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'quron_matn_olchami'.tr(),
                    style: TextStyle(
                      fontSize: AppSizes.size_16,
                      fontFamily: AppfontFamily.inter.fontFamily,
                      fontWeight: AppFontWeight.w_400,
                    ),
                  ),
                  Slider(
                      value: state.quronSize ?? _quronValue,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      activeColor: primaryColor,
                      thumbColor: Colors.white,
                      label: '${(_quronValue).toInt()}',
                      onChanged: (v) {
                        context
                            .read<QuronBloc>()
                            .add(SizeChangerEvent(quronSize: v));
                        setState(() {
                          _quronValue = v;
                        });
                      }),
                  Text(
                    'matn_olchami'.tr(),
                    style: TextStyle(
                      fontSize: AppSizes.size_16,
                      fontFamily: AppfontFamily.inter.fontFamily,
                      fontWeight: AppFontWeight.w_400,
                    ),
                  ),
                  Slider(
                      value: state.textSize ?? _matnValue,
                      min: 0,
                      max: 80,
                      divisions: 10,
                      activeColor: primaryColor,
                      thumbColor: Colors.white,
                      label: '${(_matnValue).toInt()}',
                      onChanged: (v) {
                        context
                            .read<QuronBloc>()
                            .add(SizeChangerEvent(textSize: v));
                        setState(() {
                          _matnValue = v;
                        });
                      }),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
