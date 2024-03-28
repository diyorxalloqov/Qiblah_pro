import 'package:adhan/adhan.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/profile/ui/widgets/namoz_settings_widget.dart';
import 'package:qiblah_pro/modules/profile/ui/widgets/settings_item_widget.dart';
import 'package:qiblah_pro/utils/extension/internet_checker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPremium = false;
  late ProfileBloc profileBloc;
  String selectedLang = '';

  @override
  void initState() {
    profileBloc = ProfileBloc()..add(GetUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).platformBrightness == Brightness.dark);
    // bool _onChanged = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system
    //     ? MediaQuery.of(context).platformBrightness == Brightness.dark
    //     : AdaptiveTheme.of(context).mode ==
    //         AdaptiveThemeMode
    //             .dark; // AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    // // MediaQuery.of(context).platformBrightness == Brightness.dark;
    // print(_onChanged);

    return BlocProvider(
        create: (context) => profileBloc,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  // if (state is ProfileFailed) {
                  //   return ErrorOutput(message: state.message);
                  // }
                  // if (state is ProfileLoaded) {
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: he(150),
                                width: double.infinity,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: context.isDark
                                            ? profileBlackGradient
                                            : profileGradient)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: context.isDark
                                            ? profileBlackGradient
                                            : profileGradient)),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: context.isDark
                                            ? containerBlackColor
                                            : containerColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r))),
                                    child: Column(
                                      children: [
                                        SpaceHeight(height: he(40)),
                                        Text(
                                          state.userData?.userName ?? '',
                                          style: TextStyle(
                                              fontSize: AppSizes.size_22,
                                              fontFamily: AppfontFamily
                                                  .comforta.fontFamily,
                                              fontWeight: AppFontWeight.w_700),
                                        ),
                                        const SpaceHeight(),
                                        Text(
                                          StorageRepository.getBool(
                                                  Keys.isTemporaryUser)
                                              ? 'royxatdan_otish_promt'.tr()
                                              : "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: he(AppSizes.size_14),
                                              color: smallTextColor,
                                              fontFamily: AppfontFamily
                                                  .inter.fontFamily,
                                              fontWeight: AppFontWeight.w_400),
                                        ),
                                        const SpaceHeight(),
                                        ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                    context, "editProfile",
                                                    arguments: profileBloc),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: context.isDark
                                                    ? containerBlackColor
                                                    : Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 24.w,
                                                    vertical: 12.h),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: primaryColor,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r))),
                                            child: Text(
                                              StorageRepository.getBool(
                                                      Keys.isTemporaryUser)
                                                  ? "royxatdan_otish".tr()
                                                  : 'tahrirlash'.tr(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: AppSizes.size_14,
                                                color: context.isDark
                                                    ? Colors.white
                                                    : highTextColor,
                                                fontWeight: AppFontWeight.w_500,
                                              ),
                                            )),
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 10.h),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 13.h, horizontal: 18.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            gradient: LinearGradient(
                                                colors: context.isDark
                                                    ? profileBlackGradient
                                                    : profileGradient),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  MediumText(
                                                      text: 'sizning_holatingiz'
                                                          .tr()),
                                                  Text(
                                                    isPremium
                                                        ? 'premium'.tr()
                                                        : 'oddiy'.tr(),
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontWeight:
                                                            AppFontWeight
                                                                .w_500),
                                                  )
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  isPremium = !isPremium;
                                                  setState(() {});
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                child: Container(
                                                  width: context.width * 0.32,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 6.h),
                                                  decoration: BoxDecoration(
                                                      color: isPremium
                                                          ? context.isDark
                                                              ? const Color(
                                                                      0xffD1F3E1)
                                                                  .withOpacity(
                                                                      0.2)
                                                              : Colors.white
                                                          : primaryColor,
                                                      border: isPremium
                                                          ? Border.all(
                                                              color:
                                                                  smallTextColor,
                                                              width: 0.5)
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r)),
                                                  child: isPremium
                                                      ? Column(
                                                          children: [
                                                            Text(
                                                              "tugash_sanasi"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                color: context
                                                                        .isDark
                                                                    ? smallTextWhiteColor
                                                                        .withOpacity(
                                                                            0.7)
                                                                    : smallTextColor,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              '24 dekabr 2024 ',
                                                              style: TextStyle(
                                                                color: context
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : const Color(
                                                                        0xFF1D2124),
                                                                fontSize:
                                                                    AppSizes
                                                                        .size_12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                'premiumni_yoqish'
                                                                    .tr(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                            const SpaceWidth(),
                                                            const Icon(
                                                              Icons
                                                                  .keyboard_arrow_right,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                          Positioned(
                              top: context.height * 0.1,
                              child: Container(
                                width: 90.h,
                                height: 90.h,
                                decoration: ShapeDecoration(
                                  image: state.imagePath.isNotEmpty
                                      ? DecorationImage(
                                          image:
                                              FileImage(File(state.imagePath)),
                                          fit: BoxFit.cover)
                                      : null,
                                  gradient: const LinearGradient(
                                    begin: Alignment(-0.07, -1.00),
                                    end: Alignment(0.07, 1),
                                    colors: [
                                      Color(0xFF0A9C4D),
                                      Color(0xFF1DC369),
                                      Color(0xFF21AE62)
                                    ],
                                  ),
                                  shape: const OvalBorder(),
                                ),
                                child: state.imagePath.isEmpty
                                    ? Center(
                                        child: Text(
                                        StorageRepository.getString(Keys.name)
                                                .isNotEmpty
                                            ? StorageRepository.getString(
                                                    Keys.name)
                                                .substring(0, 1)
                                            : '',
                                        style: TextStyle(
                                            fontFamily: AppfontFamily
                                                .comforta.fontFamily,
                                            fontSize: AppSizes.size_30,
                                            color: Colors.white,
                                            fontWeight: AppFontWeight.w_700),
                                      ))
                                    : const SizedBox.shrink(),
                              )),
                        ],
                      ),
                      SpaceHeight(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 14.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: context.isDark
                              ? containerBlackColor
                              : containerColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18.r),
                              topRight: Radius.circular(18.r)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ilova_sozlamalari'.tr(),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: AppSizes.size_12,
                                    fontWeight: AppFontWeight.w_400,
                                    fontFamily: AppfontFamily.inter.fontFamily),
                              ),
                              SettingsItemWidget(
                                  onTap: () => showModalBottomSheet(
                                      context: context,
                                      isDismissible: true,
                                      isScrollControlled: true,
                                      builder: (c) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                    vertical: 25.h),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(24.r),
                                                    topRight:
                                                        Radius.circular(24.r),
                                                  ),
                                                ),
                                                child: MediumText(
                                                    text: 'tilni_ozgartirish'
                                                        .tr()),
                                              ),
                                              Container(
                                                color: context.isDark
                                                    ? bottomSheetBackgroundBlackColor
                                                    : bottomSheetBackgroundColor,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w,
                                                              vertical: 13.h),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                        color: selectedLang ==
                                                                'uz'
                                                            ? primaryColor
                                                                .withOpacity(
                                                                    0.2)
                                                            : context.isDark
                                                                ? textFormFieldFillColorBlack
                                                                : Colors.white,
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await context
                                                                  .hasInternet
                                                              ? profileBloc.add(
                                                                  const ChangeAppLangEvent(
                                                                      lang:
                                                                          'uz'))
                                                              : null;
                                                          selectedLang = 'uz';
                                                          context.setLocale(
                                                              const Locale(
                                                                  'uz'));
                                                          await StorageRepository
                                                              .putString(
                                                                  Keys.lang,
                                                                  'uz');
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          "O'zbekcha",
                                                          style: AppfontFamily
                                                              .inter
                                                              .copyWith(
                                                            color: selectedLang ==
                                                                    'uz'
                                                                ? primaryColor
                                                                : context.isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            fontSize: AppSizes
                                                                .size_16,
                                                            fontWeight:
                                                                AppFontWeight
                                                                    .w_500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w,
                                                              vertical: 13.h),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                        color: selectedLang ==
                                                                'ru'
                                                            ? primaryColor
                                                                .withOpacity(
                                                                    0.2)
                                                            : context.isDark
                                                                ? textFormFieldFillColorBlack
                                                                : Colors.white,
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await context
                                                                  .hasInternet
                                                              ? profileBloc.add(
                                                                  const ChangeAppLangEvent(
                                                                      lang:
                                                                          'ru'))
                                                              : null;
                                                          selectedLang = 'ru';
                                                          context.setLocale(
                                                              const Locale(
                                                                  'ru'));
                                                          await StorageRepository
                                                              .putString(
                                                                  Keys.lang,
                                                                  'ru');

                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          "Ruscha",
                                                          style: AppfontFamily
                                                              .inter
                                                              .copyWith(
                                                            color: selectedLang ==
                                                                    'ru'
                                                                ? primaryColor
                                                                : context.isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            fontSize: AppSizes
                                                                .size_16,
                                                            fontWeight:
                                                                AppFontWeight
                                                                    .w_500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                  title: 'ilova_tili'.tr(),
                                  subtitleWidget: SmallText(
                                      text: selectedLang.isEmpty
                                          ? StorageRepository.getString(
                                                      Keys.lang) ==
                                                  'ru'
                                              ? 'Ruscha'
                                              : 'O\'zbekcha'
                                          : selectedLang == 'uz'
                                              ? 'O\'zbekcha'
                                              : 'Ruscha'),
                                  icon: AppIcon.globe),
                              Divider(
                                color: context.isDark
                                    ? const Color(0xff16171B)
                                    : const Color(0xffF5F4FA),
                              ),
                              ListTile(
                                  leading: SvgPicture.asset(AppIcon.moon,
                                      width: 24,
                                      color: context.isDark
                                          ? Colors.white.withOpacity(0.5)
                                          : smallTextColor),
                                  title: Text(
                                    'tungi_rejim'.tr(),
                                    style: TextStyle(
                                      color: context.isDark
                                          ? Colors.white
                                          : const Color(0xFF293138),
                                      fontSize: AppSizes.size_16,
                                      fontWeight: AppFontWeight.w_500,
                                      fontFamily:
                                          AppfontFamily.inter.fontFamily,
                                    ),
                                  ),
                                  trailing: Switch.adaptive(
                                    trackOutlineColor:
                                        const MaterialStatePropertyAll(
                                            Colors.white),
                                    inactiveThumbColor: Colors.white,
                                    // overlayColor:
                                    //     const MaterialStatePropertyAll(Colors.white),
                                    value: Platform.isIOS
                                        ? CupertinoAdaptiveTheme.of(context)
                                            .mode
                                            .isDark
                                        : AdaptiveTheme.of(context).mode.isDark,

                                    onChanged: (value) {
                                      if (value) {
                                        Platform.isIOS
                                            ? CupertinoAdaptiveTheme.of(context)
                                                .setDark()
                                            : AdaptiveTheme.of(context)
                                                .setDark();
                                      } else {
                                        Platform.isIOS
                                            ? CupertinoAdaptiveTheme.of(context)
                                                .setLight()
                                            : AdaptiveTheme.of(context)
                                                .setLight();
                                      }
                                    },
                                  )),
                              Divider(
                                color: context.isDark
                                    ? const Color(0xff16171B)
                                    : const Color(0xffF5F4FA),
                              ),
                              //  //////////////////////////////
                              SettingsItemWidget(
                                  onTap: () => showLocationBottomSheet(context),
                                  title: 'manzil'.tr(),
                                  subtitleWidget: Text(
                                      StorageRepository.getString(Keys.region)),
                                  icon: AppIcon.location)
                            ]),
                        //////////////
                      ),
                      SpaceHeight(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          color: context.isDark
                              ? containerBlackColor
                              : containerColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'namoz_sozlamalari'.tr(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: AppSizes.size_15,
                                  fontWeight: AppFontWeight.w_500,
                                ),
                              ),
                              const SpaceHeight(),
                              BlocBuilder<NamozTimeBloc, NamozTimeState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      SettingsItemWidget(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const NamozSettingsWidget(
                                                      choices:
                                                          PrayerCalculationMethod
                                                              .values);
                                                });
                                          },
                                          title: 'hisoblash_usuli'.tr(),
                                          subtitle: state
                                                  .chosenCalculationMethod
                                                  ?.title ??
                                              'hisoblash_usuli'.tr(),
                                          icon: AppIcon.timeChanger),
                                      SettingsItemWidget(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const NamozSettingsWidget(
                                                      choices: Madhab.values);
                                                });
                                          },
                                          title: 'madhab'.tr(),
                                          subtitle: state.chosenMadhab.name,
                                          icon: AppIcon.timeChanger),
                                      SettingsItemWidget(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const NamozSettingsWidget(
                                                      choices: HighLatitudeRule
                                                          .values);
                                                });
                                          },
                                          title: 'Asr_hisoblash_uslubi'.tr(),
                                          subtitle:
                                              state.chosenHighLatitudeRule.name,
                                          icon: AppIcon.timeChanger),
                                    ],
                                  );
                                },
                              ),
                            ]),
                      ),
                    ],
                  );
                  // }
                  // return Loading();
                },
              ),
            ),
          ),
        ));
  }
}
