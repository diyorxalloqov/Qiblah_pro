import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/presentation/widgets/lang_bottom_sheet.dart';
import 'package:qiblah_pro/modules/onBoarding/presentation/widgets/location_bottom_sheet.dart';
import 'package:qiblah_pro/modules/profile/ui/widgets/settings_item_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPremium = false;
  late ProfileBloc profileBloc;
  int selectedChipIndex = 0;
  final List<String> _titles = const ['ayol', "erkak"];
  final List<String> _icons = const [AppIcon.woman, AppIcon.man];

  @override
  void initState() {
    profileBloc = ProfileBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _onChanged = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return BlocProvider(
      create: (context) => profileBloc,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: context.height * 0.2,
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.green.shade100,
                            Colors.lightGreen.shade100,
                            Colors.green.shade100
                          ])),
                        ),
                        BottomAppBar(
                            notchMargin: 8.0,
                            height: context.height * 0.3,
                            color: Colors.white,
                            clipBehavior: Clip.antiAlias,
                            shape: const CircularNotchedRectangle(),
                            elevation: 0,
                            child: Column(
                              children: [
                                const SizedBox(width: double.infinity),
                                SpaceHeight(height: context.height * 0.022),
                                const Text(
                                  'Eshonov Fakhriyor',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: AppFontWeight.w_700,
                                  ),
                                ),
                                const SpaceHeight(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SmallText(text: 'faolligi'.tr()),
                                    const SpaceWidth(),
                                    const Text(
                                      '11.12.2023 dan ',
                                      style: TextStyle(
                                        fontSize: AppSizes.size_14,
                                        fontWeight: AppFontWeight.w_400,
                                      ),
                                    )
                                  ],
                                ),
                                const SpaceHeight(),
                                ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, "editProfile",
                                        arguments: profileBloc),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.w, vertical: 12.h),
                                        fixedSize: Size(115.w, 40.h),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: primaryColor, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(12.r))),
                                    child: Center(
                                      child: Text(
                                        "tahrirlash".tr(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: AppSizes.size_14,
                                          color: highTextColor,
                                          fontWeight: AppFontWeight.w_500,
                                        ),
                                      ),
                                    )),
                                const SpaceHeight(),
                                Container(
                                  width: double.infinity,
                                  height: context.height * 0.078,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 18.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    gradient: LinearGradient(colors: [
                                      Colors.green.shade100,
                                      Colors.lightGreen.shade100,
                                      Colors.green.shade100
                                    ]),
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
                                              text: 'sizning_holatingiz'.tr()),
                                          Text(
                                            isPremium
                                                ? 'premium'.tr()
                                                : 'oddiy'.tr(),
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight:
                                                    AppFontWeight.w_500),
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
                                          height: context.height * 0.06,
                                          width: context.width * 0.3,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                              color: isPremium
                                                  ? Colors.white
                                                  : primaryColor,
                                              border: isPremium
                                                  ? Border.all(
                                                      color: smallTextColor,
                                                      width: 0.5)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(12.r)),
                                          child: isPremium
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      "tugash_sanasi".tr(),
                                                      style: TextStyle(
                                                        color: smallTextColor,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const Text(
                                                      '24 dekabr 2024 ',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF1D2124),
                                                        fontSize:
                                                            AppSizes.size_12,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                        'premiumni_yoqish'.tr(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.white,
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
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                    Positioned(
                        top: context.height * 0.12,
                        child: Container(
                          width: 100.r,
                          height: 100.r,
                          decoration: const ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.07, -1.00),
                              end: Alignment(0.07, 1),
                              colors: [
                                Color(0xFF0A9C4D),
                                Color(0xFF1DC369),
                                Color(0xFF21AE62)
                              ],
                            ),
                            shape: OvalBorder(),
                          ),
                          child: const Center(child: Text("data")),
                        )),
                  ],
                ),
                const SpaceHeight(),
                const SpaceHeight(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                  height: context.height * 0.33,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ilova_sozlamalari'.tr(),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: AppSizes.size_15,
                            fontWeight: AppFontWeight.w_500,
                          ),
                        ),
                        SettingsItemWidget(
                            onTap: () => showLangBottomSheet(context),
                            title: 'ilova_tili'.tr(),
                            subtitle: "O’zbekcha",
                            icon: AppIcon.globe),
                        ListTile(
                            leading: SvgPicture.asset(AppIcon.moon,
                                width: 24, color: smallTextColor),
                            title: Text(
                              'tungi_rejim'.tr(),
                              style: const TextStyle(
                                color: Color(0xFF293138),
                                fontSize: AppSizes.size_16,
                                fontWeight: AppFontWeight.w_500,
                              ),
                            ),
                            trailing: Switch.adaptive(
                              value: _onChanged,
                              trackOutlineColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              inactiveThumbColor: Colors.white,
                              // overlayColor:
                              //     const MaterialStatePropertyAll(Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  _onChanged = value;
                                });
                                final newBrightness =
                                    value ? Brightness.dark : Brightness.light;
                                AdaptiveTheme.of(context).setThemeMode(
                                    newBrightness == Brightness.dark
                                        ? AdaptiveThemeMode.dark
                                        : AdaptiveThemeMode.light);
                              },
                            )),
                        SettingsItemWidget(
                            onTap: () => showLocationBottomSheet(context),
                            title: 'manzil'.tr(),
                            subtitle: "O’zbekcha",
                            icon: AppIcon.location)
                      ]),
                ),
                const SpaceHeight(),
                const SpaceHeight(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                  height: context.height * 0.42,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
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
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: List.generate(2, (index) {
                            return ChoiceChip(
                              label: SizedBox(
                                height: 40.h,
                                width: 150.w,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(_icons[index]),
                                    Text(
                                      _titles[index].tr(),
                                      style:  TextStyle(
                                          fontSize: AppSizes.size_16,
                                          color: highTextColor,
                                          fontWeight: AppFontWeight.w_500),
                                    ),
                                  ],
                                ),
                              ),
                              side: selectedChipIndex == index
                                  ? BorderSide(color: primaryColor, width: 1)
                                  : BorderSide.none,
                              showCheckmark: false,
                              backgroundColor: scaffoldColor,
                              selectedColor: primaryColor.withOpacity(0.2),
                              disabledColor: textFormFieldHintColor,
                              onSelected: (value) {
                                print(value);
                                setState(() {
                                  print(selectedChipIndex);
                                  print(index);

                                  if (value) {
                                    selectedChipIndex = index;
                                  }
                                });
                              },
                              selected: selectedChipIndex == index,
                            );
                          }),
                        ),
                        SettingsItemWidget(
                            onTap: () {},
                            title: 'Namoz_vaqtlari_manbasi'.tr(),
                            subtitle: "O’zbekiston Loremlar idorasi",
                            icon: AppIcon.globe),
                        SettingsItemWidget(
                            onTap: () {},
                            title: 'Namoz_vaqtlari_manbasi'.tr(),
                            subtitle: "O’zbekiston Loremlar idorasi",
                            icon: AppIcon.globe),
                        SettingsItemWidget(
                            onTap: () {},
                            title: 'Asr_hisoblash_uslubi'.tr(),
                            subtitle: "hanafiy".tr(),
                            icon: AppIcon.globe)
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
