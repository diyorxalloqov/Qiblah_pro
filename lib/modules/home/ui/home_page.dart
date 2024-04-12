import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/blocs/tapes/tapes_bloc.dart';
import 'package:qiblah_pro/modules/home/ui/widgets/tapes_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  late TimeCountDownCubit _timeCountDownCubit;
  late TapesBloc _tapesBloc;

  final GlobalKey _cardKey = GlobalKey();
  final GlobalKey _cardKey1 = GlobalKey();
  final GlobalKey _cardKey2 = GlobalKey();
  final GlobalKey _cardKey3 = GlobalKey();
  double cardHeight = 300;
  double cardHeight1 = 250;
  double cardHeight2 = 250;
  double cardHeight3 = 250;
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    NamozTimeBloc namozBloc = context.read<NamozTimeBloc>();
    context.read<GeolocationCubit>().getSavedLocation();
    namozBloc.add(const CurrentNamozTimes());
    namozBloc.add(LoadSettings());
    _timeCountDownCubit = TimeCountDownCubit();
    _timeCountDownCubit.startCoundDown(
        namozBloc.state.latitude ?? StorageRepository.getDouble(Keys.latitude),
        namozBloc.state.longtitude ??
            StorageRepository.getDouble(Keys.longitude));

    _tapesBloc = TapesBloc();
  }

  @override
  void dispose() {
    _timeCountDownCubit.cancelTimes();
    super.dispose();
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
              child: BlocBuilder<NamozTimeBloc, NamozTimeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentNamozTime(state).hhMM(),
                                style: TextStyle(
                                  fontSize: he(AppSizes.size_24),
                                  color: context.isDark
                                      ? Colors.white
                                      : highTextColor,
                                  fontWeight: AppFontWeight.w_700,
                                ),
                              ),
                              const SpaceHeight(),
                              BlocProvider.value(
                                value: _timeCountDownCubit,
                                child: SizedBox(
                                  width: 150.w,
                                  child: BlocBuilder<TimeCountDownCubit,
                                      TimeCountDownState>(
                                    builder: (context, state1) {
                                      return Text(
                                        currentNamozName(state, state1),
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
                                ),
                              ),
                              const SpaceHeight(),
                              Row(
                                children: [
                                  Text(
                                    "barchasini_korish".tr(),
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily:
                                            AppfontFamily.inter.fontFamily,
                                        fontSize: he(AppSizes.size_14),
                                        fontWeight: AppFontWeight.w_700),
                                  ),
                                  const SpaceWidth(),
                                  SvgPicture.asset(AppIcon.arrowRight,
                                      color: primaryColor, width: 30.w)
                                ],
                              )
                            ],
                          )),
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
                                      state.capital ??
                                          StorageRepository.getString(
                                              Keys.capital),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: context.isDark
                                            ? const Color(0xffB5B9BC)
                                            : const Color(0xff6D7379),
                                        fontSize: AppSizes.size_12,
                                        fontFamily:
                                            AppfontFamily.inter.fontFamily,
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
                  );
                },
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: isTapped ? 260.h : 161.h),
            padding:
                EdgeInsets.only(bottom: 5.h, top: 18.h, right: 12, left: 12.w),
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
                    isTapped
                        ? const SizedBox(height: 32)
                        : InkWell(
                            onTap: () {
                              isTapped = true;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Text(
                                  "barchasini_korish".tr(),
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily:
                                          AppfontFamily.inter.fontFamily,
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
                    child: isTapped
                        ? GridView.builder(
                            itemCount: 5,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 8.w,
                                    crossAxisCount: 4),
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.w, right: 5.w),
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
                                                side: BorderSide.none),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                                _icons[index],
                                                width: 40,
                                                color: context.isDark
                                                    ? Colors.white70
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
                                              fontFamily: AppfontFamily
                                                  .inter.fontFamily,
                                              fontSize: AppSizes.size_12),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(left: 20.w, right: 5.w),
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
                                              side: BorderSide.none),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(_icons[index],
                                              width: 40,
                                              color: context.isDark
                                                  ? Colors.white70
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
                isTapped
                    ? GestureDetector(
                        onTap: () {
                          isTapped = false;
                          setState(() {});
                        },
                        child:
                            Icon(Icons.keyboard_arrow_up, color: primaryColor))
                    : const SizedBox.shrink()
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

          /// ads card
          // if (index == 0) {
          //   return GestureDetector(
          //     onTap: () =>
          //         Navigator.pushNamed(context, 'newsDetail'),
          //     child: Container(
          //       width: context.width,
          //       height: he(234),
          //       margin: EdgeInsets.only(right: 12.w),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12.r),
          //           color: context.isDark
          //               ? homeBlackMainColor
          //               : Colors.grey),
          //     ),
          //   );
          // }
          BlocProvider.value(
            value: _tapesBloc,
            child: BlocBuilder<TapesBloc, TapesState>(
              builder: (context, state) {
                if (state.status == ActionStatus.isLoading) {
                  return const TapesShimmer();
                }
                if (state.status == ActionStatus.isSuccess) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: he(cardHeight / 2)),
                          Container(
                            height: 18,
                            width: 18,
                            margin: EdgeInsets.symmetric(horizontal: 10..w),
                            decoration: ShapeDecoration(
                                color: context.isDark
                                    ? primaryColor
                                    : const Color(0xffD1F3E1),
                                shape: const OvalBorder()),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Dash(
                                dashThickness: 2,
                                direction: Axis.vertical,
                                length: he(
                                    ((cardHeight ~/ 2) + (cardHeight1 ~/ 2))
                                            .toDouble() -
                                        18.h),
                                dashLength: 15,
                                dashGap: 10,
                                dashColor: primaryColor),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                margin: EdgeInsets.symmetric(horizontal: 10..w),
                                decoration: ShapeDecoration(
                                    color: context.isDark
                                        ? primaryColor
                                        : const Color(0xffD1F3E1),
                                    shape: const OvalBorder()),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Dash(
                                    dashThickness: 2,
                                    direction: Axis.vertical,
                                    length: he(((cardHeight1 ~/ 2) +
                                                (cardHeight2 ~/ 2))
                                            .toDouble() -
                                        18.h),
                                    dashLength: 15,
                                    dashGap: 10,
                                    dashColor: primaryColor),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                margin: EdgeInsets.symmetric(horizontal: 10..w),
                                decoration: ShapeDecoration(
                                    color: context.isDark
                                        ? primaryColor
                                        : const Color(0xffD1F3E1),
                                    shape: const OvalBorder()),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Dash(
                                    dashThickness: 2,
                                    direction: Axis.vertical,
                                    length: he(((cardHeight2 ~/ 2) +
                                                (cardHeight3 ~/ 2))
                                            .toDouble() -
                                        18.h),
                                    dashLength: 15,
                                    dashGap: 10,
                                    dashColor: primaryColor),
                              ),
                            ],
                          ),
                          Container(
                            height: 18,
                            width: 18,
                            margin: EdgeInsets.symmetric(horizontal: 10..w),
                            decoration: ShapeDecoration(
                                color: context.isDark
                                    ? primaryColor
                                    : const Color(0xffD1F3E1),
                                shape: const OvalBorder()),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Builder(
                              builder: (BuildContext context) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  RenderBox? renderBox = _cardKey.currentContext
                                      ?.findRenderObject() as RenderBox?;
                                  if (renderBox != null) {
                                    // double cardWidth = renderBox.size.width;
                                    cardHeight = renderBox.size.height;
                                    setState(() {});
                                    // debugPrint("Card height: $cardHeight");
                                  }
                                });
                                return CardWidget(
                                  key: _cardKey,
                                  zikrNumber:
                                      '(${state.tapesModel?.verse?.juzNumber ?? 0}:${state.tapesModel?.verse?.verseNumber ?? 0})',
                                  lentaName: 'kun_oyati'.tr(),
                                  isZikr: true,
                                  name: state.tapesModel?.verse?.meaning ?? '',
                                  description:
                                      state.tapesModel?.verse?.verseArabic ??
                                          '',
                                  onTap: () =>
                                      Navigator.pushNamed(context, 'quron'),
                                  textDirection: TextDirection.rtl,
                                );
                              },
                            ),
                            Builder(
                              builder: (BuildContext context) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  RenderBox? renderBox = _cardKey1
                                      .currentContext
                                      ?.findRenderObject() as RenderBox?;
                                  if (renderBox != null) {
                                    cardHeight1 = renderBox.size.height;
                                    setState(() {});
                                    // debugPrint("Card height1: $cardHeight1");
                                  }
                                });
                                return CardWidget(
                                    key: _cardKey1,
                                    zikrNumber: '',
                                    lentaName: 'kun_zikri'.tr(),
                                    isZikr: false,
                                    name:
                                        state.tapesModel?.zikr?.zikrTitle ?? '',
                                    description: state.tapesModel?.zikr
                                            ?.zikrDescription ??
                                        '',
                                    onTap: () =>
                                        Navigator.pushNamed(context, 'zikr'));
                              },
                            ),
                            Builder(
                              builder: (BuildContext context) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  RenderBox? renderBox = _cardKey2
                                      .currentContext
                                      ?.findRenderObject() as RenderBox?;
                                  if (renderBox != null) {
                                    cardHeight2 = renderBox.size.height;
                                    setState(() {});
                                    // debugPrint("Card height2: $cardHeight2");
                                  }
                                });
                                return CardWidget(
                                  key: _cardKey2,
                                  lentaName: 'asmaul_husna'.tr(),
                                  isZikr: true,
                                  onTap: () =>
                                      Navigator.pushNamed(context, 'names'),
                                  name: state.tapesModel?.name?.title ?? '',
                                  description:
                                      state.tapesModel?.name?.description ?? '',
                                  zikrNumber:
                                      '${state.tapesModel?.name?.nameId ?? 0} - ${'ism'.tr()}',
                                );
                              },
                            ),
                            Builder(
                              builder: (BuildContext context) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  RenderBox? renderBox = _cardKey3
                                      .currentContext
                                      ?.findRenderObject() as RenderBox?;
                                  if (renderBox != null) {
                                    cardHeight3 = renderBox.size.height;
                                    // debugPrint("Card height3: $cardHeight3");
                                    setState(() {});
                                  }
                                });
                                return CardWidget(
                                  key: _cardKey3,
                                  lentaName: 'kun_duosi'.tr(),
                                  isZikr: false,
                                  onTap: () =>
                                      Navigator.pushNamed(context, 'zikr'),
                                  zikrNumber: '',
                                  name: state.tapesModel?.dua?.zikrTitle ?? '',
                                  description:
                                      state.tapesModel?.dua?.zikrDescription ??
                                          '',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          SizedBox(height: he(60))
        ],
      ),
    );
  }

  DateTime currentNamozTime(NamozTimeState state) {
    if (state.dailyTimes != null) {
      if (state.dailyTimes!.bomdod.isCurrent) {
        return state.dailyTimes!.quyosh.time;
      } else if (state.dailyTimes!.quyosh.isCurrent) {
        return state.dailyTimes!.peshin.time;
      } else if (state.dailyTimes!.peshin.isCurrent) {
        return state.dailyTimes!.asr.time;
      } else if (state.dailyTimes!.asr.isCurrent) {
        return state.dailyTimes!.shom.time;
      } else if (state.dailyTimes!.shom.isCurrent) {
        return state.dailyTimes!.xufton.time;
      } else if (state.dailyTimes!.xufton.isCurrent) {
        return state.dailyTimes!.bomdod.time;
      } else {
        return state.dailyTimes!.bomdod.time;
      }
    } else {
      return DateTime.now();
    }
  }
}

String currentNamozName(NamozTimeState state, TimeCountDownState state1) {
  String hour = state1.durationUntilNextPrayer != Duration.zero
      ? state1.durationUntilNextPrayer.getFormattedCountdownHour()
      : '';
  String minute = state1.durationUntilNextPrayer != Duration.zero
      ? state1.durationUntilNextPrayer.getFormattedCountdownMinute()
      : '';
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
      return "${'bomdod'.tr()} ${hour != '0' ? hour : ''} ${hour != '0' && hour.isNotEmpty ? ('soat'.tr()) : ''} ${minute != '0' ? minute : ''} ${minute != '0' && minute.isNotEmpty ? ("daqiqadan_song").tr() : ''}";
    }
  } else {
    return '';
  }
}
