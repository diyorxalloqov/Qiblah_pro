import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class Korsatish extends StatefulWidget {
  const Korsatish({super.key});

  @override
  State<Korsatish> createState() => _KorsatishState();
}

class _KorsatishState extends State<Korsatish> {
  bool oqilishi = true;
  bool manosi = true;
  bool arabchasi = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuronBloc, QuronState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          color:
              context.isDark ? homeBlackMainColor : bottomSheetBackgroundColor,
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
                    'arabcha_shakli'.tr(),
                    style: TextStyle(
                      fontSize: AppSizes.size_16,
                      fontFamily: AppfontFamily.inter.fontFamily,
                      fontWeight: AppFontWeight.w_400,
                    ),
                  ),
                  Switch.adaptive(
                    activeTrackColor: primaryColor,
                    inactiveTrackColor: Colors.white,
                    activeColor: Colors.white,
                    value: state.textEnum == QuronShowingTextEnum.arabic,
                    onChanged: (v) {
                      context.read<QuronBloc>().add(const ShowingTextEvent(
                          text: QuronShowingTextEnum.arabic));
                      arabchasi = v;
                      setState(() {});
                    },
                  )
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
                      value: state.textEnum == QuronShowingTextEnum.reading,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: Colors.white,
                      onChanged: (v) {
                        oqilishi = v;
                        context.read<QuronBloc>().add(const ShowingTextEvent(
                            text: QuronShowingTextEnum.reading));
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
                      value: state.textEnum == QuronShowingTextEnum.meaning,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: Colors.white,
                      onChanged: (v) {
                        manosi = v;
                        context.read<QuronBloc>().add(const ShowingTextEvent(
                            text: QuronShowingTextEnum.meaning));
                        setState(() {});
                      })
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
