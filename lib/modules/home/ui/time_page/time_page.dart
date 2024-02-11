import 'package:hijri/hijri_calendar.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/blocs/namoz_time/namoz_time_bloc.dart';
import 'package:qiblah_pro/modules/home/blocs/namoz_time/time_count_down/time_count_down_cubit.dart';
import 'package:qiblah_pro/modules/home/blocs/namoz_time/time_count_down/time_count_down_state.dart';
import 'package:qiblah_pro/modules/home/ui/widgets/time_item_widget.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/cubit/geolocation_cubit.dart';
import 'package:qiblah_pro/utils/date_utils.dart';
import 'package:qiblah_pro/utils/extension/daily_prayer_time.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  HijriCalendar hijriToday = HijriCalendar.now();
  late TimeCountDownCubit _timeCountDownCubit;
  bool _isBomdod = true;
  bool _isQuyosh = true;
  bool _isPeshin = true;
  bool _isAsr = true;
  bool _isShom = true;
  bool _isXufton = true;

  @override
  void initState() {
    _timeCountDownCubit = TimeCountDownCubit();
    context.read<NamozTimeBloc>().add(TodayNamozTimes());
    super.initState();
  }

  @override
  void dispose() {
    _timeCountDownCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _timeCountDownCubit,
        child: BlocBuilder<NamozTimeBloc, NamozTimeState>(
          builder: (context, state) {
            if (state.error.isNotEmpty) {
              return Text('Error: ${state.error}');
            }
            if (state.dailyTimes == null) {
              // Handle the case where state is null
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      /////  logic image change with time
                      image: SvgImage.asset(currentImage(state)),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Column(
                  children: [
                    const SpaceHeight(),
                    const SpaceHeight(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Container(
                              width: 28,
                              height: 28,
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: SvgPicture.asset(AppIcon.arrowLeft,
                                  color: iconButtonColor),
                            )),
                        const SpaceWidth(),
                        Text(
                          currentNamozTime(state).hhMM(),
                          style: TextStyle(
                            color: highTextColorWhite,
                            fontSize: AppSizes.size_42,
                            fontFamily: AppfontFamily.comforta.fontFamily,
                            fontWeight: AppFontWeight.w_700,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {},
                                icon: Container(
                                  width: 28,
                                  height: 28,
                                  padding: const EdgeInsets.all(2),
                                  decoration: ShapeDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: SvgPicture.asset(AppIcon.share,
                                      color: iconButtonColor),
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'taqvimPage');
                                },
                                icon: Container(
                                  width: 28,
                                  height: 28,
                                  padding: const EdgeInsets.all(3),
                                  decoration: ShapeDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: SvgPicture.asset(AppIcon.calendar,
                                      color: iconButtonColor),
                                )),
                          ],
                        )
                      ],
                    ),
                    const SpaceHeight(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<TimeCountDownCubit, TimeCountDownState>(
                          builder: (context, state) {
                            return state.durationUntilNextPrayer !=
                                    Duration.zero
                                ? Text(
                                    "-${state.durationUntilNextPrayer.getFormattedCountdown()}",
                                    style: TextStyle(
                                        fontSize: AppSizes.size_16,
                                        color: Colors.white,
                                        fontFamily:
                                            AppfontFamily.inter.fontFamily,
                                        fontWeight: AppFontWeight.w_400),
                                  )
                                : const SizedBox();
                          },
                        ),
                        const SpaceWidth(),
                        Text(
                          currentNamozName(state).tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.size_16,
                              fontFamily: AppfontFamily.inter.fontFamily,
                              fontWeight: AppFontWeight.w_400),
                        )
                      ],
                    ),
                    const SpaceHeight(),
                    GestureDetector(
                      onTap: () {
                        showLocationBottomSheet(context);
                      },
                      child: Container(
                        width: context.width * 0.38,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                future: context
                                    .read<GeolocationCubit>()
                                    .getChosenLocation(),
                                builder: (context, snapshot) {
                                  return Expanded(
                                    child: Text(
                                      snapshot.data?.region.toString() ??
                                          'not found',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppSizes.size_16,
                                        fontFamily:
                                            AppfontFamily.inter.fontFamily,
                                        fontWeight: AppFontWeight.w_400,
                                      ),
                                    ),
                                  );
                                }),
                            SvgPicture.asset(AppIcon.edit)
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(AppIcon.arrowLeft,
                                    color: iconButtonColor)),
                            const SpaceWidth(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${'bugun'.tr()}: ${DateFormat('dd.MM.yyyy').format(DateTime.now())}',
                                  style: TextStyle(
                                    color: smallTextWhiteColor,
                                    fontSize: AppSizes.size_16,
                                    fontFamily:
                                        AppfontFamily.comforta.fontFamily,
                                    fontWeight: AppFontWeight.w_700,
                                  ),
                                ),
                                Text(
                                  hijriToday.fullDate(),
                                  style: TextStyle(
                                    color: smallTextWhiteColor,
                                    fontSize: AppSizes.size_14,
                                    fontFamily:
                                        AppfontFamily.comforta.fontFamily,
                                    fontWeight: AppFontWeight.w_400,
                                  ),
                                ),
                              ],
                            ),
                            const SpaceWidth(),
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(AppIcon.arrowRight1,
                                    color: iconButtonColor))
                          ],
                        )
                      ],
                    ),
                    SpaceHeight(height: 18.h),
                    Container(
                      height: 310.w,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.r),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: state.dailyTimes!.bomdod.isCurrent
                                ? const Color(0x1905FF2D)
                                : null,
                            child: TimeItem(
                                namozName: 'bomdod'.tr(),
                                time: state.dailyTimes!.bomdod.time.hhMM(),
                                icon: _isBomdod
                                    ? SvgPicture.asset(AppIcon.volume)
                                    : const Icon(Icons.volume_off_outlined,
                                        color: Colors.white),
                                volumeOnTap: () async {
                                  _isBomdod = !_isBomdod;
                                  setState(() {});

                                  DateTime time = DateTime.now()
                                      .add(const Duration(seconds: 3));
                                  print(time);
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            color: state.dailyTimes!.quyosh.isCurrent
                                ? const Color(0x1905FF2D)
                                : null,
                            child: TimeItem(
                                namozName: 'quyosh'.tr(),
                                time: state.dailyTimes!.quyosh.time.hhMM(),
                                icon: _isQuyosh
                                    ? SvgPicture.asset(AppIcon.volume)
                                    : const Icon(Icons.volume_off_outlined,
                                        color: Colors.white),
                                volumeOnTap: () {
                                  _isQuyosh = !_isQuyosh;
                                  setState(() {});
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            color: state.dailyTimes!.peshin.isCurrent
                                ? const Color(0x1905FF2D)
                                : null,
                            child: TimeItem(
                                namozName: 'peshin'.tr(),
                                time: state.dailyTimes!.peshin.time.hhMM(),
                                icon: _isPeshin
                                    ? SvgPicture.asset(AppIcon.volume)
                                    : const Icon(Icons.volume_off_outlined,
                                        color: Colors.white),
                                volumeOnTap: () {
                                  _isPeshin = !_isPeshin;
                                  setState(() {});
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            color: state.dailyTimes!.asr.isCurrent
                                ? const Color(0x1905FF2D)
                                : null,
                            child: TimeItem(
                                namozName: 'asr'.tr(),
                                time: state.dailyTimes!.asr.time.hhMM(),
                                icon: _isAsr
                                    ? SvgPicture.asset(AppIcon.volume)
                                    : const Icon(Icons.volume_off_outlined,
                                        color: Colors.white),
                                volumeOnTap: () {
                                  _isAsr = !_isAsr;
                                  setState(() {});
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            color: state.dailyTimes!.shom.isCurrent
                                ? const Color(0x1905FF2D)
                                : null,
                            child: TimeItem(
                                namozName: 'shom'.tr(),
                                time: state.dailyTimes!.shom.time.hhMM(),
                                icon: _isShom
                                    ? SvgPicture.asset(AppIcon.volume)
                                    : const Icon(Icons.volume_off_outlined,
                                        color: Colors.white),
                                volumeOnTap: () {
                                  _isShom = !_isShom;
                                  setState(() {});
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            color: state.dailyTimes!.xufton.isCurrent
                                ? const Color(0x1905FF2D)
                                : null,
                            child: TimeItem(
                                namozName: 'xufton'.tr(),
                                time: state.dailyTimes!.xufton.time.hhMM(),
                                icon: _isXufton
                                    ? SvgPicture.asset(AppIcon.volume)
                                    : const Icon(Icons.volume_off_outlined,
                                        color: Colors.white),
                                volumeOnTap: () {
                                  _isXufton = !_isXufton;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                    ),
                    SpaceHeight(height: context.bottom + 50)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String currentNamozName(NamozTimeState state) {
    if (state.dailyTimes!.bomdod.isCurrent) {
      return 'quyosh';
    } else if (state.dailyTimes!.quyosh.isCurrent) {
      return 'peshin';
    } else if (state.dailyTimes!.peshin.isCurrent) {
      return 'asr';
    } else if (state.dailyTimes!.asr.isCurrent) {
      return 'shom';
    } else if (state.dailyTimes!.shom.isCurrent) {
      return 'xufton';
    } else if (state.dailyTimes!.xufton.isCurrent) {
      return 'bomdod';
    } else {
      return 'xufton';
    }
  }

  String currentImage(NamozTimeState state) {
    if (state.dailyTimes!.bomdod.isCurrent) {
      return AppIcon.time_bomdod;
    } else if (state.dailyTimes!.quyosh.isCurrent) {
      return AppIcon.time_peshin;
    } else if (state.dailyTimes!.peshin.isCurrent) {
      return AppIcon.time_peshin;
    } else if (state.dailyTimes!.asr.isCurrent) {
      return AppIcon.time_asr;
    } else if (state.dailyTimes!.shom.isCurrent) {
      return AppIcon.time_shom;
    } else if (state.dailyTimes!.xufton.isCurrent) {
      return AppIcon.time_xufton;
    } else {
      return AppIcon.time_bomdod;
    }
  }

  DateTime currentNamozTime(NamozTimeState state) {
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
  }
}
