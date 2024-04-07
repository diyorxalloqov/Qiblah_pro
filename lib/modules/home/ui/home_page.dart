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
    "quron",
    "ficha_qibla",
    "ficha_qazo",
    "ficha_zikr",
    "ficha_99_names"
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
            centerTitle: false,
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
                MediumText(
                    text:
                        '${('assalom_alekum').tr()} ${StorageRepository.getString(Keys.name)}'),
                SizedBox(height: 4.h),
                SmallText(text: "ibodatlaringiz_qabul_bolsin".tr())
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'TimePage'),
            child: Container(
              constraints: BoxConstraints(maxHeight: 135.h),
              padding: EdgeInsets.only(left: 18.w, right: 10.w),
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
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentTime,
                          style: TextStyle(
                            fontSize: he(AppSizes.size_24),
                            color:
                                context.isDark ? Colors.white : highTextColor,
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
                        Row(
                          children: [
                            Text(
                              "barchasini_korish".tr(),
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: AppfontFamily.inter.fontFamily,
                                  fontSize: he(AppSizes.size_14),
                                  fontWeight: AppFontWeight.w_700),
                            ),
                            const SpaceWidth(),
                            SvgPicture.asset(AppIcon.arrowRight,
                                color: primaryColor, width: 30.w)
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.only(
                            right: 8.w, left: 8.w, top: 3.h, bottom: 3.h),
                        decoration: BoxDecoration(
                          color: context.isDark
                              ? const Color(0xff232C37)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: SizedBox(
                          width: 70.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  StorageRepository.getString(Keys.capital),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: context.isDark
                                        ? const Color(0xffB5B9BC)
                                        : const Color(0xff6D7379),
                                    fontSize: AppSizes.size_12,
                                    fontFamily: AppfontFamily.inter.fontFamily,
                                    fontWeight: AppFontWeight.w_500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              SvgPicture.asset(AppIcon.location)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      SvgPicture.asset(AppIcon.moshid, width: 100.w),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 161.h),
            padding:
                EdgeInsets.only(bottom: 18.h, top: 18.h, right: 12, left: 12.w),
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
                          fontSize: he(AppSizes.size_16),
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
                                fontSize: he(AppSizes.size_14),
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
                            padding: EdgeInsets.only(left: 20.w, right: 5.w),
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
                                          width: 40,
                                          color: context.isDark
                                              ? const Color(0xff6D7379)
                                              : null),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    _names[index].tr(),
                                    style: TextStyle(
                                        color: context.isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily:
                                            AppfontFamily.inter.fontFamily,
                                        fontSize: AppSizes.size_12),
                                  )
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
              style: TextStyle(
                fontSize: AppSizes.size_16,
                fontFamily: AppfontFamily.comforta.fontFamily,
                fontWeight: AppFontWeight.w_700,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///// dash list
              Column(
                children: [
                  SpaceHeight(height: 108.h),
                  Column(
                    children: List.generate(
                        7 + 1,
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
                                      length: he(250),
                                      /*  */
                                      dashBorderRadius: 10,
                                      dashLength: 10,
                                      dashGap: 10,
                                      dashColor: primaryColor),
                                  if (index == 7)
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: ShapeDecoration(
                                          color: context.isDark
                                              ? primaryColor
                                              : const Color(0xffD1F3E1),
                                          shape: const OvalBorder()),
                                    )
                                ],
                              ),
                            )),
                  ),
                ],
              ),

              /// card list
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(10, (index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'newsDetail'),
                        child: Container(
                          height: he(234),
                          margin: EdgeInsets.only(right: 12.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: context.isDark
                                  ? homeBlackMainColor
                                  : Colors.grey),
                        ),
                      );
                    }
                    return const CardWidget();
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: he(60))
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
    print(hour);
    if (state.dailyTimes != null) {
      if (state.dailyTimes!.bomdod.isCurrent) {
        return "${'quyosh'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' && hour.isNotEmpty ? ('soat'.tr()) : ''} ${minute != '0' ? minute : ''} ${minute != '0' && minute.isNotEmpty ? ("daqiqadan_song").tr() : ''}";
      } else if (state.dailyTimes!.quyosh.isCurrent) {
        return "${'peshin'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' && hour.isNotEmpty ? ('soat'.tr()) : ''} ${minute != '0' ? minute : ''} ${minute != '0' && minute.isNotEmpty ? ("daqiqadan_song").tr() : ''}";
      } else if (state.dailyTimes!.peshin.isCurrent) {
        return "${'asr'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' && hour.isNotEmpty ? ('soat'.tr()) : ''} ${minute != '0' ? minute : ''} ${minute != '0' && minute.isNotEmpty ? ("daqiqadan_song").tr() : ''}";
      } else if (state.dailyTimes!.asr.isCurrent) {
        return "${'shom'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' && hour.isNotEmpty ? ('soat'.tr()) : ''} ${minute != '0' ? minute : ''} ${minute != '0' && minute.isNotEmpty ? ("daqiqadan_song").tr() : ''}";
      } else if (state.dailyTimes!.shom.isCurrent) {
        return "${'xufton'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' && hour.isNotEmpty ? ('soat'.tr()) : ''} ${minute != '0' ? minute : ''} ${minute != '0' && minute.isNotEmpty ? ("daqiqadan_song").tr() : ''}";
      } else if (state.dailyTimes!.xufton.isCurrent) {
        return "${'bomdod'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' && hour.isNotEmpty ? ('soat'.tr()) : ''} ${minute != '0' ? minute : ''} ${minute != '0' && minute.isNotEmpty ? ("daqiqadan_song").tr() : ''}";
      } else {
        return 'bomdod'.tr();
      }
    } else {
      return '';
    }
  }
}
