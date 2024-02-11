import 'package:hijri/hijri_calendar.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/blocs/namoz_time/namoz_time_bloc.dart';
import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';
import 'package:qiblah_pro/modules/onBoarding/geolocation/cubit/geolocation_cubit.dart';
import 'package:qiblah_pro/utils/extension/daily_prayer_time.dart';

class TaqvimPage extends StatefulWidget {
  const TaqvimPage({super.key});

  @override
  State<TaqvimPage> createState() => _TaqvimPageState();
}

class _TaqvimPageState extends State<TaqvimPage> {
  final List<String> _names = [
    'sana',
    'bomdod',
    'quyosh',
    'peshin',
    'asr',
    'shom',
    'xufton'
  ];

  final NamozTimeBloc _namozTimeBloc = NamozTimeBloc();
  HijriCalendar hijriToday = HijriCalendar.now();

  @override
  void initState() {
    super.initState();
    _namozTimeBloc.add(CurrentMonthNamozTimes());
  }

  @override
  void dispose() {
    _namozTimeBloc.add(TodayNamozTimes());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NamozTimeBloc, NamozTimeState>(
        bloc: _namozTimeBloc,
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 220.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(AppImages.taqvim_back),
                      fit: BoxFit.cover),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SpaceHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Container(
                                width: 28,
                                height: 28,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4F7FA),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: SvgPicture.asset(AppIcon.arrowLeft),
                              )),
                          const SpaceWidth(),
                          Text(
                            "namoz_taqvimi".tr(),
                            style: TextStyle(
                              fontSize: AppSizes.size_18,
                              fontFamily: AppfontFamily.comforta.fontFamily,
                              fontWeight: AppFontWeight.w_700,
                            ),
                          ),
                          const SpaceWidth(),
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(AppIcon.share, width: 30))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcon.calendar,
                              color: primaryColor, width: 20),
                          const SpaceWidth(),
                          Text(
                            '${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}, ${hijriToday.fullDate().replaceAll(RegExp(','), "")}',
                            style: TextStyle(
                              fontSize: AppSizes.size_16,
                              fontFamily: AppfontFamily.inter.fontFamily,
                              fontWeight: AppFontWeight.w_500,
                            ),
                          ),
                        ],
                      ),
                      const SpaceHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcon.location, width: 20),
                          const SpaceWidth(),
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
                                    fontSize: AppSizes.size_16,
                                    fontFamily: AppfontFamily.inter.fontFamily,
                                    fontWeight: AppFontWeight.w_400,
                                  ),
                                );
                              }),
                        ],
                      ),
                      const SpaceHeight(),
                      Text(
                        'namoz_taqvimi_promt'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppSizes.size_10,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: AppFontWeight.w_400,
                            color: smallTextColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SpaceHeight(),
              const SpaceHeight(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r))),
                child: Table(
                  border: TableBorder.symmetric(
                      outside: BorderSide.none,
                      inside: BorderSide(color: tableColor, width: 1)),
                  children: List.generate(state.currentMonthTimes.length + 1,
                      (colIndex) {
                    if (colIndex == 0) {
                      // sana uchun row
                      return TableRow(
                        children: List.generate(_names.length, (rowIndex1) {
                          return TableCell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 5),
                              child: Center(
                                child: Text(
                                  _names[rowIndex1],
                                  style: TextStyle(
                                    color: const Color(0xff6D7379),
                                    fontSize: AppSizes.size_12,
                                    fontFamily: AppfontFamily.inter.fontFamily,
                                    fontWeight: AppFontWeight.w_400,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    }
                    List<PrayerTime> names = [
                      state.currentMonthTimes[colIndex - 1].bomdod,
                      state.currentMonthTimes[colIndex - 1].quyosh,
                      state.currentMonthTimes[colIndex - 1].peshin,
                      state.currentMonthTimes[colIndex - 1].asr,
                      state.currentMonthTimes[colIndex - 1].shom,
                      state.currentMonthTimes[colIndex - 1].xufton,
                    ];
                    return TableRow(
                      decoration: BoxDecoration(
                        color:
                            colIndex % 2 == 0 ? const Color(0xffF4F8FA) : null,
                      ),
                      children: List.generate(_names.length, (rowIndex) {
                        if (rowIndex == 0) {
                          // sana uchun column
                          return TableCell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 5),
                              child: Center(
                                child: Text('$colIndex'),
                              ),
                            ),
                          );
                        }
                        return TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 5),
                            child: Center(
                              child: Text(
                                names[rowIndex - 1].time.hhMM(),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
              const SpaceHeight()
            ],
          );
        },
      ),
    );
  }
}
