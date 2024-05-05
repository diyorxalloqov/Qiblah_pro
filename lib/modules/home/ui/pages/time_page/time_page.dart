import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  late TimeCountDownCubit _timeCountDownCubit;
  bool _isBomdod = StorageRepository.getBool(Keys.bomdodNotification);
  bool _isQuyosh = StorageRepository.getBool(Keys.quyoshNotification);
  bool _isPeshin = StorageRepository.getBool(Keys.peshinNotification);
  bool _isAsr = StorageRepository.getBool(Keys.asrNotification);
  bool _isShom = StorageRepository.getBool(Keys.shomNotification);
  bool _isXufton = StorageRepository.getBool(Keys.xuftonNotification);
  bool isNext = false;
  bool isPrev = false;
  late DateTime _displayedDate;
  late HijriCalendar _hijriToday;
  int _currentDay = 0;
  late PageController _pageController;

  @override
  void initState() {
    NamozTimeBloc bloc = context.read<NamozTimeBloc>();
    bloc.add(const CurrentNamozTimes());
    _timeCountDownCubit = TimeCountDownCubit()
      ..startCoundDown(
          bloc.state.latitude ?? StorageRepository.getDouble(Keys.latitude),
          bloc.state.longtitude ?? StorageRepository.getDouble(Keys.longitude));
    for (int i = 0; i < bloc.state.currentMonthTimes.length; i++) {
      currentDay(i, bloc);
    }
    _pageController = PageController(initialPage: _currentDay);
    _displayedDate = DateTime.now()
        .add(Duration(days: bloc.state.currentMonthTimes.length))
        .copyWith(month: DateTime.now().month, year: DateTime.now().year);
    _hijriToday = HijriCalendar.now();
    super.initState();
  }

  void currentDay(int i, NamozTimeBloc bloc) {
    if (bloc.state.currentMonthTimes[i].bomdod.time ==
            bloc.state.dailyTimes?.bomdod.time ||
        bloc.state.currentMonthTimes[i].quyosh.time ==
            bloc.state.dailyTimes?.quyosh.time ||
        bloc.state.currentMonthTimes[i].peshin.time ==
            bloc.state.dailyTimes?.peshin.time ||
        bloc.state.currentMonthTimes[i].asr.time ==
            bloc.state.dailyTimes?.asr.time ||
        bloc.state.currentMonthTimes[i].shom.time ==
            bloc.state.dailyTimes?.shom.time ||
        bloc.state.currentMonthTimes[i].xufton.time ==
            bloc.state.dailyTimes?.xufton.time) {
      _currentDay = i;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    // _timeCountDownCubit.cancelTimes();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<GeolocationCubit>().getSavedLocation();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _timeCountDownCubit,
        child: BlocBuilder<NamozTimeBloc, NamozTimeState>(
          builder: (context, state) {
            if (state.status == ActionStatus.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state.status == ActionStatus.isSuccess) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: context.height,
                  width: context.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: SvgPicture.asset(currentImage(state),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover)),
                      Positioned(
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SpaceHeight(),
                              const SpaceHeight(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: ShapeDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: SvgPicture.asset(
                                            AppIcon.arrowLeft,
                                            color: iconButtonColor),
                                      )),
                                  const SpaceWidth(),
                                  Text(
                                    currentNamozTime(state).hhMM(),
                                    style: TextStyle(
                                      color: highTextColorWhite,
                                      fontSize: AppSizes.size_42,
                                      fontFamily:
                                          AppfontFamily.comforta.fontFamily,
                                      fontWeight: AppFontWeight.w_700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Container(
                                            width: 28,
                                            height: 28,
                                            padding: const EdgeInsets.all(2),
                                            decoration: ShapeDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                            ),
                                            child: SvgPicture.asset(
                                                AppIcon.share,
                                                color: iconButtonColor),
                                          )),
                                      IconButton(
                                          onPressed: () => Navigator.pushNamed(
                                              context, 'taqvimPage'),
                                          icon: Container(
                                            width: 28,
                                            height: 28,
                                            padding: const EdgeInsets.all(3),
                                            decoration: ShapeDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                            ),
                                            child: SvgPicture.asset(
                                                AppIcon.calendar,
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
                                  BlocBuilder<TimeCountDownCubit,
                                      TimeCountDownState>(
                                    builder: (context, state) {
                                      return state.durationUntilNextPrayer !=
                                              Duration.zero
                                          ? Text(
                                              "-${state.durationUntilNextPrayer.getFormattedCountdown()}",
                                              style: TextStyle(
                                                  fontSize: AppSizes.size_16,
                                                  color: Colors.white,
                                                  fontFamily: AppfontFamily
                                                      .inter.fontFamily,
                                                  fontWeight:
                                                      AppFontWeight.w_400),
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
                                        fontFamily:
                                            AppfontFamily.inter.fontFamily,
                                        fontWeight: AppFontWeight.w_400),
                                  )
                                ],
                              ),
                              const SpaceHeight(),
                              GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  isDismissible: true,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => LocationBottomSheet(
                                      timeCountDownCubit: _timeCountDownCubit),
                                ),
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 100.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(50.r)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          StorageRepository.getString(
                                              Keys.capital),
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
                                      ),
                                      SvgPicture.asset(AppIcon.edit)
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 385.h,
                                child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: state.currentMonthTimes.length,
                                    onPageChanged: (value) {
                                      setState(() {
                                        _displayedDate = DateTime.now().add(
                                            Duration(
                                                days: value - _currentDay));
                                        // _displayedDate = DateTime(_displayedDate.year,
                                        //         _displayedDate.month, 1)
                                        //     .add(Duration(days: value - _currentDay));

                                        _hijriToday = HijriCalendar.fromDate(
                                            _displayedDate);
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      debugPrint(" index");
                                      print(" current day");
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed: () => _pageController
                                                        .previousPage(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            curve:
                                                                Curves.easeIn),
                                                    icon: SvgPicture.asset(
                                                        AppIcon.arrowLeft,
                                                        color:
                                                            iconButtonColor)),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${index == _currentDay ? "bugun".tr() : ''} ${DateFormat('dd.MM.yyyy').format(_displayedDate)}',
                                                      style: TextStyle(
                                                        color:
                                                            smallTextWhiteColor,
                                                        fontSize:
                                                            AppSizes.size_16,
                                                        fontFamily:
                                                            AppfontFamily
                                                                .comforta
                                                                .fontFamily,
                                                        fontWeight:
                                                            AppFontWeight.w_700,
                                                      ),
                                                    ),
                                                    Text(
                                                      _hijriToday.fullDate(),
                                                      style: TextStyle(
                                                        color:
                                                            smallTextWhiteColor,
                                                        fontSize:
                                                            AppSizes.size_14,
                                                        fontFamily:
                                                            AppfontFamily
                                                                .comforta
                                                                .fontFamily,
                                                        fontWeight:
                                                            AppFontWeight.w_400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () =>
                                                        _pageController.nextPage(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            curve:
                                                                Curves.easeIn),
                                                    icon: SvgPicture.asset(
                                                        AppIcon.arrowRight1,
                                                        color: iconButtonColor))
                                              ],
                                            ),
                                          ),
                                          SpaceHeight(height: 18.h),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.r),
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: index ==
                                                              _currentDay
                                                          ? state
                                                                      .dailyTimes
                                                                      ?.bomdod
                                                                      .isCurrent ??
                                                                  false
                                                              ? const Color(
                                                                  0x1905FF2D)
                                                              : null
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      18.r),
                                                              topRight: Radius
                                                                  .circular(
                                                                      18.r))),
                                                  child: TimeItem(
                                                      namozName: 'bomdod'.tr(),
                                                      time: state
                                                          .currentMonthTimes[
                                                              index]
                                                          .bomdod
                                                          .time
                                                          .hhMM(),
                                                      icon: _isBomdod
                                                          ? SvgPicture.asset(
                                                              AppIcon.volume)
                                                          : const Icon(
                                                              Icons
                                                                  .volume_off_outlined,
                                                              color:
                                                                  Colors.white),
                                                      volumeOnTap: index ==
                                                              _currentDay
                                                          ? () async {
                                                              _isBomdod =
                                                                  !_isBomdod;
                                                              setState(() {});

                                                              // _isBomdod
                                                              //     ? context
                                                              //         .read<
                                                              //             NamozTimeBloc>()
                                                              //         .add(const ScheduleNotificationEvent(
                                                                        
                                                              //             namoz:
                                                              //                 NamozEnum.bomdod))
                                                              //     : null;

                                                              await StorageRepository
                                                                  .putBool(
                                                                      Keys.bomdodNotification,
                                                                      _isBomdod);
                                                            }
                                                          : null),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  color: index == _currentDay
                                                      ? state.dailyTimes?.quyosh
                                                                  .isCurrent ??
                                                              false
                                                          ? const Color(
                                                              0x1905FF2D)
                                                          : null
                                                      : null,
                                                  child: TimeItem(
                                                      namozName: 'quyosh'.tr(),
                                                      time: state
                                                          .currentMonthTimes[
                                                              index]
                                                          .quyosh
                                                          .time
                                                          .hhMM(),
                                                      icon: _isQuyosh
                                                          ? SvgPicture.asset(
                                                              AppIcon.volume)
                                                          : const Icon(
                                                              Icons
                                                                  .volume_off_outlined,
                                                              color:
                                                                  Colors.white),
                                                      volumeOnTap: index ==
                                                              _currentDay
                                                          ? () async {
                                                              _isQuyosh =
                                                                  !_isQuyosh;
                                                              setState(() {});
                                                              // _isQuyosh
                                                              //     ? context
                                                              //         .read<
                                                              //             NamozTimeBloc>()
                                                              //         .add(const ScheduleNotificationEvent(
                                                              //             namoz:
                                                              //                 NamozEnum.quyosh))
                                                              //     : null;
                                                              await StorageRepository
                                                                  .putBool(
                                                                      Keys.quyoshNotification,
                                                                      _isQuyosh);
                                                            }
                                                          : null),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  color: index == _currentDay
                                                      ? state.dailyTimes?.peshin
                                                                  .isCurrent ??
                                                              false
                                                          ? const Color(
                                                              0x1905FF2D)
                                                          : null
                                                      : null,
                                                  child: TimeItem(
                                                      namozName: 'peshin'.tr(),
                                                      time: state
                                                          .currentMonthTimes[
                                                              index]
                                                          .peshin
                                                          .time
                                                          .hhMM(),
                                                      icon: _isPeshin
                                                          ? SvgPicture.asset(
                                                              AppIcon.volume)
                                                          : const Icon(
                                                              Icons
                                                                  .volume_off_outlined,
                                                              color:
                                                                  Colors.white),
                                                      volumeOnTap: index ==
                                                              _currentDay
                                                          ? () async {
                                                              _isPeshin =
                                                                  !_isPeshin;
                                                              setState(() {});
                                                              // _isPeshin
                                                              //     ? context
                                                              //         .read<
                                                              //             NamozTimeBloc>()
                                                              //         .add(const ScheduleNotificationEvent(
                                                              //             namoz:
                                                              //                 NamozEnum.peshin))
                                                              //     : null;
                                                              await StorageRepository
                                                                  .putBool(
                                                                      Keys.peshinNotification,
                                                                      _isPeshin);
                                                            }
                                                          : null),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  color: index == _currentDay
                                                      ? state.dailyTimes?.asr
                                                                  .isCurrent ??
                                                              false
                                                          ? const Color(
                                                              0x1905FF2D)
                                                          : null
                                                      : null,
                                                  child: TimeItem(
                                                      namozName: 'asr'.tr(),
                                                      time: state
                                                          .currentMonthTimes[
                                                              index]
                                                          .asr
                                                          .time
                                                          .hhMM(),
                                                      icon: _isAsr
                                                          ? SvgPicture.asset(
                                                              AppIcon.volume)
                                                          : const Icon(
                                                              Icons
                                                                  .volume_off_outlined,
                                                              color:
                                                                  Colors.white),
                                                      volumeOnTap: index ==
                                                              _currentDay
                                                          ? () async {
                                                              _isAsr = !_isAsr;
                                                              setState(() {});
                                                              // _isAsr
                                                              //     ? context
                                                              //         .read<
                                                              //             NamozTimeBloc>()
                                                              //         .add(const ScheduleNotificationEvent(
                                                              //             namoz:
                                                              //                 NamozEnum.asr))
                                                              //     : null;
                                                              await StorageRepository
                                                                  .putBool(
                                                                      Keys.asrNotification,
                                                                      _isAsr);
                                                            }
                                                          : null),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  color: index == _currentDay
                                                      ? state.dailyTimes?.shom
                                                                  .isCurrent ??
                                                              false
                                                          ? const Color(
                                                              0x1905FF2D)
                                                          : null
                                                      : null,
                                                  child: TimeItem(
                                                      namozName: 'shom'.tr(),
                                                      time: state
                                                          .currentMonthTimes[
                                                              index]
                                                          .shom
                                                          .time
                                                          .hhMM(),
                                                      icon: _isShom
                                                          ? SvgPicture.asset(
                                                              AppIcon.volume)
                                                          : const Icon(
                                                              Icons
                                                                  .volume_off_outlined,
                                                              color:
                                                                  Colors.white),
                                                      volumeOnTap: index ==
                                                              _currentDay
                                                          ? () async {
                                                              _isShom =
                                                                  !_isShom;
                                                              setState(() {});
                                                              // _isShom
                                                              //     ? context
                                                              //         .read<
                                                              //             NamozTimeBloc>()
                                                              //         .add(const ScheduleNotificationEvent(
                                                              //             namoz:
                                                              //                 NamozEnum.shom))
                                                              //     : null;
                                                              await StorageRepository
                                                                  .putBool(
                                                                      Keys.shomNotification,
                                                                      _isShom);
                                                            }
                                                          : null),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: index ==
                                                              _currentDay
                                                          ? state
                                                                      .dailyTimes
                                                                      ?.xufton
                                                                      .isCurrent ??
                                                                  false
                                                              ? const Color(
                                                                  0x1905FF2D)
                                                              : null
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      18.r),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      18.r))),
                                                  child: TimeItem(
                                                      namozName: 'xufton'.tr(),
                                                      time: state
                                                          .currentMonthTimes[
                                                              index]
                                                          .xufton
                                                          .time
                                                          .hhMM(),
                                                      icon: _isXufton
                                                          ? SvgPicture.asset(
                                                              AppIcon.volume)
                                                          : const Icon(
                                                              Icons
                                                                  .volume_off_outlined,
                                                              color:
                                                                  Colors.white),
                                                      volumeOnTap: index ==
                                                              _currentDay
                                                          ? () async {
                                                              _isXufton =
                                                                  !_isXufton;
                                                              setState(() {});
                                                              // _isXufton
                                                              //     ? context
                                                              //         .read<
                                                              //             NamozTimeBloc>()
                                                              //         .add(const ScheduleNotificationEvent(
                                                              //             namoz:
                                                              //                 NamozEnum.xufton))
                                                              //     : null;
                                                              await StorageRepository
                                                                  .putBool(
                                                                      Keys.xuftonNotification,
                                                                      _isXufton);
                                                            }
                                                          : null),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state.status == ActionStatus.isError) {
              return Center(child: Text(state.error));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  String currentImage(NamozTimeState state) {
    if (state.dailyTimes != null) {
      if (state.dailyTimes!.bomdod.isCurrent) {
        return AppIcon.time_bomdod;
      } else if (state.dailyTimes!.quyosh.isCurrent ||
          state.dailyTimes!.peshin.isCurrent) {
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
    } else {
      return AppIcon.apple;
    }
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

String currentNamozName(NamozTimeState state) {
  if (state.dailyTimes != null) {
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
      return 'bomdod';
    }
  } else {
    return 'Xatolik';
  }
}
