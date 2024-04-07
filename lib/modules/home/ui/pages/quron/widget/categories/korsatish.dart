import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class Korsatish extends StatefulWidget {
  const Korsatish({super.key});

  @override
  State<Korsatish> createState() => _KorsatishState();
}

class _KorsatishState extends State<Korsatish> {
  final List<String> _title = [
    'arabcha_shakli',
    'oqilishi',
    'manolar_tarjimasi'
  ];
  final List<bool> _switchs = [true, true, true];

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
              Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SpaceHeight(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _title[index].tr(),
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
                                value: index == 0
                                    ? state.isShowingArabic
                                    : index == 1
                                        ? state.isShowingReading
                                        : state.isShowingMeaning,
                                onChanged: (v) {
                                  // if (state.isShowingArabic &&
                                  //     state.isShowingMeaning) {
                                  //   context.read<QuronBloc>().add(
                                  //       ShowingTextEvent(
                                  //           index: index, isShowing: v));
                                  // } else if (state.isShowingArabic &&
                                  //     state.isShowingReading) {
                                  //   context.read<QuronBloc>().add(
                                  //       ShowingTextEvent(
                                  //           index: index, isShowing: v));
                                  // } else if (state.isShowingMeaning &&
                                  //     state.isShowingReading) {
                                  //   context.read<QuronBloc>().add(
                                  //       ShowingTextEvent(
                                  //           index: index, isShowing: v));
                                  // } else {
                                  //   showToastMessage('Xato', context);
                                  // }
                                  context.read<QuronBloc>().add(
                                      ShowingTextEvent(
                                          index: index, isShowing: v));
                                },
                              )
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
