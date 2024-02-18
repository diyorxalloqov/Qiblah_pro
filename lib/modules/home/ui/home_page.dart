import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _currentTime;

  final List<String> _names = const [
    "Qur'on",
    "Qibla",
    "Qazo counter",
    "Zikr",
    "99 games"
  ];

  final List<String> _icons = const [
    AppIcon.quron,
    AppIcon.qibla,
    AppIcon.qazo_counter,
    AppIcon.zikr,
    AppIcon.Godnames
  ];

  final List<String> _itemPages = const [
    'quron',
    'qibla',
    'qazo',
    'zikr',
    'names'
  ];

  late TimeCountDownCubit timeCountDownCubit;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    context.read<NamozTimeBloc>().add(TodayNamozTimes());
    timeCountDownCubit = TimeCountDownCubit();
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime();
    });
  }

  @override
  void dispose() {
    timeCountDownCubit.close();
    _timer.cancel();
    super.dispose();
  }

  void _updateCurrentTime() {
    setState(() {
      _currentTime = '${DateTime.now().hour.toString().padLeft(2, '0')}:'
          '${DateTime.now().minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            scrolledUnderElevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 5.h),
                MediumText(text: '${('assalom_alekum').tr()}, Sherzod!'),
                SizedBox(height: 5.h),
                SmallText(text: "ibodatlaringiz_qabul_bolsin".tr())
              ],
            ),
          ),
          Container(
            height: 150.h,
            padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: context.isDark ? homeBlackMainColor : null,
                borderRadius: BorderRadius.circular(12.r),
                gradient: context.isDark
                    ? null
                    : LinearGradient(colors: [
                        smallTextColor.withOpacity(0.15),
                        const Color(0xff7CD722).withOpacity(0.25),
                        const Color(0xff0A9D4E).withOpacity(0.2)
                      ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentTime,
                      style: TextStyle(
                        fontSize: AppSizes.size_24,
                        color: context.isDark ? Colors.white : highTextColor,
                        fontWeight: AppFontWeight.w_700,
                      ),
                    ),
                    const SpaceHeight(),
                    BlocProvider.value(
                      value: timeCountDownCubit,
                      child: BlocBuilder<NamozTimeBloc, NamozTimeState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: 150.w,
                            child: BlocBuilder<TimeCountDownCubit,
                                TimeCountDownState>(
                              builder: (context, state1) {
                                return Text(
                                  currentNamozTime(state, state1),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Color(0xFF6D7379),
                                    fontSize: AppSizes.size_12,
                                    fontWeight: AppFontWeight.w_400,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SpaceHeight(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'TimePage');
                      },
                      child: Row(
                        children: [
                          Text(
                            "barchasini_korish".tr(),
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: AppfontFamily.inter.fontFamily,
                                fontSize: AppSizes.size_14,
                                fontWeight: AppFontWeight.w_700),
                          ),
                          const SpaceWidth(),
                          SvgPicture.asset(AppIcon.arrowRight,
                              color: primaryColor, width: 30.w)
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.only(right: 10.w, left: 10.w, top: 6.h),
                      decoration: BoxDecoration(
                        color: context.isDark
                            ? const Color(0xff232C37)
                            : const Color(0xFFE3F6DC).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Row(
                        children: [
                          FutureBuilder(
                              future: context
                                  .read<GeolocationCubit>()
                                  .getChosenLocation(),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data?.region.toString() ??
                                      'not found',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: context.isDark
                                        ? const Color(0xffB5B9BC)
                                        : const Color(0xff6D7379),
                                    fontSize: AppSizes.size_16,
                                    fontFamily: AppfontFamily.inter.fontFamily,
                                    fontWeight: AppFontWeight.w_400,
                                  ),
                                );
                              }),
                          const SpaceWidth(),
                          SvgPicture.asset(AppIcon.location)
                        ],
                      ),
                    ),
                    SvgPicture.asset(AppIcon.moshid, width: 100.w),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: context.height * 0.2,
            padding: EdgeInsets.only(bottom: 18.h, top: 18.h, left: 12.w),
            decoration: ShapeDecoration(
              color: context.isDark ? homeBlackMainColor : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "bizning_xizmatlar".tr(),
                      style: TextStyle(
                          color: context.isDark ? Colors.white : highTextColor,
                          fontSize: AppSizes.size_16,
                          fontFamily: AppfontFamily.comforta.fontFamily,
                          fontWeight: AppFontWeight.w_700),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, 'detailPage'),
                      child: Row(
                        children: [
                          Text(
                            "barchasini_korish".tr(),
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: AppfontFamily.inter.fontFamily,
                                fontSize: AppSizes.size_14,
                                fontWeight: AppFontWeight.w_700),
                          ),
                          const SpaceWidth(),
                          SvgPicture.asset(AppIcon.arrowRight,
                              color: primaryColor, width: 30.w),
                          const SpaceWidth(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 18.w),
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, _itemPages[index]),
                              borderRadius: BorderRadius.circular(50.r),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      color: context.isDark
                                          ? xizmatlarItemBlack
                                          : xizmatlarItem,
                                      shape: const OvalBorder(
                                          side: BorderSide(
                                              color: Colors.black, width: 0.1)),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(_icons[index],
                                          color: context.isDark
                                              ? const Color(0xff6D7379)
                                              : null),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(_names[index])
                                ],
                              ),
                            ),
                          );
                        })),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Text(
              "kunlik_ilm".tr(),
              style: const TextStyle(
                fontSize: AppSizes.size_16,
                fontWeight: AppFontWeight.w_700,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SpaceHeight(height: 130.h),
                  Column(
                    children: List.generate(
                        11 + 1,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 18,
                                    width: 18,
                                    decoration: ShapeDecoration(
                                        color: context.isDark
                                            ? primaryColor
                                            : const Color(0xffD1F3E1),
                                        shape: const OvalBorder()),
                                  ),
                                  Dash(
                                    dashThickness: 2,
                                    direction: Axis.vertical,
                                    length: 230,
                                    /*  */
                                    dashBorderRadius: 10,
                                    dashLength: 10,
                                    dashGap: 10,
                                    dashColor: primaryColor,
                                  ),
                                ],
                              ),
                            )),
                  ),
                ],
              ),
              Column(
                children: List.generate(
                    11,
                    (index) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (index == 0)
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'newsDetail');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: context.bottom + 10),
                                  height: context.height * 0.3,
                                  width: context.width * 0.85,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: context.isDark
                                          ? homeBlackMainColor
                                          : Colors.grey),
                                ),
                              ),
                            const CardWidget(),
                          ],
                        )),
              )
            ],
          )
        ],
      ),
    );
  }

  String currentNamozTime(NamozTimeState state, TimeCountDownState state1) {
    String hour = state1.durationUntilNextPrayer != Duration.zero
        ? state1.durationUntilNextPrayer.getFormattedCountdownHour()
        : '';
    String minute = state1.durationUntilNextPrayer != Duration.zero
        ? state1.durationUntilNextPrayer.getFormattedCountdownMinute()
        : '';
    if (state.dailyTimes != null) {
      if (state.dailyTimes!.bomdod.isCurrent) {
        return "${'quyosh'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' ? ('soat'.tr()) : ''} $minute ${("daqiqadan_song").tr()}";
      } else if (state.dailyTimes!.quyosh.isCurrent) {
        return "${'peshin'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' ? ('soat'.tr()) : ''} $minute ${("daqiqadan_song").tr()}";
      } else if (state.dailyTimes!.peshin.isCurrent) {
        return "${'asr'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' ? ('soat'.tr()) : ''} $minute ${("daqiqadan_song").tr()}";
      } else if (state.dailyTimes!.asr.isCurrent) {
        return "${'shom'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' ? ('soat'.tr()) : ''} $minute ${("daqiqadan_song").tr()}";
      } else if (state.dailyTimes!.shom.isCurrent) {
        return "${'xufton'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' ? ('soat'.tr()) : ''} $minute ${("daqiqadan_song").tr()}";
      } else if (state.dailyTimes!.xufton.isCurrent) {
        return "${'bomdod'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' ? ('soat'.tr()) : ''} $minute ${("daqiqadan_song").tr()}";
      } else {
        return "${'bomdod'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' ? ('soat'.tr()) : ''} $minute ${("daqiqadan_song").tr()}";
      }
    } else {
      return '';
    }
  }
}
