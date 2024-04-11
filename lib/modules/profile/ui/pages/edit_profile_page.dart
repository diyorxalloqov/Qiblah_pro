import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/profile/ui/widgets/password_bottomsheet.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileBloc profileBloc;
  const EditProfilePage({super.key, required this.profileBloc});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with WidgetsBindingObserver {
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  late GlobalKey<FormState> _key;

  int selectedChipIndex = StorageRepository.getBool(Keys.isMan) ? 1 : 0;
  final List<String> _titles = const ['ayol', "erkak"];
  final List<String> _icons = const [AppIcon.woman, AppIcon.man];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    _key = GlobalKey<FormState>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.profileBloc.add(GetUserData());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Image was previously selected, notify the profileBloc
      widget.profileBloc.add(GetUserdataForEdit());
    }
  }

  String dialCode = '+998';
  bool isMan = true;
  bool isRegistered = false;

  @override
  Widget build(BuildContext context) {
    final FlCountryCodePicker countryPicker = FlCountryCodePicker(
        searchBarDecoration: InputDecoration(
      filled: true,
      hintText: 'davlatni_tanlang'.tr(),
      hintStyle: TextStyle(
        fontSize: AppSizes.size_16,
        fontWeight: AppFontWeight.w_400,
        color: textFormFieldHintColor,
      ),
      fillColor:
          context.isDark ? textFormFieldFillColorBlack : textFormFieldFillColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12.0),
      ),
    ));
    return Scaffold(
        appBar: customAppbar(
          context,
          "profilni_tahrirlash".tr(),
          icon1: AppIcon.logout,
          onTap1: () {
            showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'chiqish'.tr(),
                            style: TextStyle(
                                fontFamily: AppfontFamily.comforta.fontFamily,
                                fontSize: AppSizes.size_18,
                                fontWeight: AppFontWeight.w_700),
                          ),
                          SpaceHeight(height: context.height * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () => Navigator.maybePop(context),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    fixedSize: Size(100.w, 30.h),
                                  ),
                                  child: Text(
                                    'yoq'.tr(),
                                    style: TextStyle(
                                        color: context.isDark
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    if (!StorageRepository.getBool(
                                        Keys.isTemporaryUser)) {
                                      widget.profileBloc.add(LogoutEvent());
                                      Navigator.pop(context);
                                      SystemNavigator.pop();
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'royxatdan_otmagansiz'
                                                      .tr())));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      fixedSize: Size(100.w, 30.h),
                                      backgroundColor: primaryColor),
                                  child: Text(
                                    'ha'.tr(),
                                    style: const TextStyle(color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ));
          },
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: widget.profileBloc,
          builder: (context, state) {
            _nameController.text = state.userData?.userName ?? '';
            _phoneController.text = state.userData?.userPhoneNumber ?? '';
            return SingleChildScrollView(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => showAdaptiveDialog(
                              context: context,
                              builder: (context) => ImagePickerWidget(
                                  profileBloc: widget.profileBloc)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Container(
                                    width: 90.r,
                                    height: 90.r,
                                    decoration: ShapeDecoration(
                                      image: state.imagePath.isEmpty
                                          ? null
                                          : DecorationImage(
                                              image: FileImage(
                                                  File(state.imagePath)),
                                              fit: BoxFit.cover),
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
                                    child: state.imagePath.isNotEmpty
                                        ? const SizedBox.shrink()
                                        : const Icon(Icons.person_rounded,
                                            color: Colors.white, size: 42)),
                                Container(
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: context.isDark
                                            ? Colors.black
                                            : Colors.white),
                                    child: SvgPicture.asset(
                                        state.imagePath.isEmpty
                                            ? AppIcon.camera
                                            : AppIcon.edit,
                                        color: state.imagePath.isNotEmpty
                                            ? context.isDark
                                                ? Colors.white
                                                : Colors.black
                                            : null)),
                              ],
                            ),
                          ),
                        ),
                        SpaceHeight(height: 24.h),
                        SmallText(text: 'ismingiz_nima'.tr()),
                        Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'ismingizni_yozing'.tr(),
                                    hintStyle: TextStyle(
                                        fontSize: AppSizes.size_16,
                                        fontWeight: AppFontWeight.w_400,
                                        color: textFormFieldHintColor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    fillColor: context.isDark
                                        ? textFormFieldFillColorBlack
                                        : Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: context.isDark
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: context.isDark
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'validator_prop'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SpaceHeight(height: 15.h),
                              SmallText(text: 'telefon_raqamingiz'.tr()),
                              const SpaceHeight(),
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'telefon_raqam'.tr(),
                                  hintStyle: TextStyle(
                                      fontSize: AppSizes.size_16,
                                      fontWeight: AppFontWeight.w_400,
                                      color: textFormFieldHintColor),
                                  prefixIcon: TextButton(
                                      onPressed: () async {
                                        final picked =
                                            await countryPicker.showPicker(
                                          context: context,
                                          backgroundColor: context.isDark
                                              ? bottomSheetBackgroundBlackColor
                                              : bottomSheetBackgroundColor,
                                        );
                                        dialCode = picked?.dialCode ?? '+998';
                                        setState(() {});
                                      },
                                      child: Text(
                                        dialCode,
                                        style: TextStyle(
                                            color: context.isDark
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                  fillColor: context.isDark
                                      ? textFormFieldFillColorBlack
                                      : Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: context.isDark
                                        ? BorderSide.none
                                        : BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  border: OutlineInputBorder(
                                    borderSide: context.isDark
                                        ? BorderSide.none
                                        : BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'validator_prop'.tr();
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SpaceHeight(height: 24.h),
                        SizedBox(
                          height: 50.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(2, (index) {
                              return ChoiceChip(
                                backgroundColor: context.isDark
                                    ? jinsBlackColor
                                    : Colors.white,
                                label: SizedBox(
                                  width: 130.w,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(_icons[index]),
                                      const SpaceWidth(),
                                      Text(
                                        _titles[index].tr(),
                                        style: TextStyle(
                                            fontSize: AppSizes.size_16,
                                            color: context.isDark
                                                ? highTextColorWhite
                                                : highTextColor,
                                            fontWeight: AppFontWeight.w_500),
                                      ),
                                    ],
                                  ),
                                ),
                                side: selectedChipIndex == index
                                    ? BorderSide(color: primaryColor, width: 1)
                                    : BorderSide.none,
                                showCheckmark: false,
                                selectedColor: primaryColor.withOpacity(0.2),
                                disabledColor: textFormFieldHintColor,
                                onSelected: (value) {
                                  debugPrint(value.toString());
                                  index == 0 ? isMan = false : isMan = true;
                                  setState(() {
                                    if (value) {
                                      selectedChipIndex = index;
                                    } else {
                                      selectedChipIndex = -1;
                                    }
                                  });
                                },
                                selected: selectedChipIndex == index,
                              );
                            }),
                          ),
                        ),
                        SpaceHeight(height: 20.h),
                        InkWell(
                          onTap: () {
                            StorageRepository.getBool(Keys.isTemporaryUser)
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('parol_prop'.tr())))
                                : showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (c) =>
                                        const EditPasswordBottomSheet());
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            height: he(48),
                            decoration: BoxDecoration(
                                color: smallTextColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppIcon.key,
                                      color: context.isDark
                                          ? Colors.white54
                                          : null),
                                  const SpaceWidth(),
                                  MediumText(text: "parolni_ozgartirish".tr())
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SpaceHeight(),
                        const SpaceHeight(),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                showAdaptiveDialog(
                                    context: context,
                                    builder: (context) => AlertDialog.adaptive(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'ochirish'.tr(),
                                                style: TextStyle(
                                                    fontFamily: AppfontFamily
                                                        .comforta.fontFamily,
                                                    fontSize: AppSizes.size_18,
                                                    fontWeight:
                                                        AppFontWeight.w_700),
                                              ),
                                              SpaceHeight(
                                                  height:
                                                      context.height * 0.05),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.maybePop(
                                                              context),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r),
                                                        ),
                                                        fixedSize:
                                                            Size(100.w, 30.h),
                                                      ),
                                                      child: Text(
                                                        'yoq'.tr(),
                                                        style: TextStyle(
                                                            color: context
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                      )),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        widget.profileBloc.add(
                                                            DeleteAccauntEvent());
                                                        Navigator.pop(context);
                                                        SystemNavigator.pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.r),
                                                              ),
                                                              fixedSize: Size(
                                                                  100.w, 30.h),
                                                              backgroundColor:
                                                                  primaryColor),
                                                      child: Text(
                                                        'ha'.tr(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(AppIcon.user),
                                  const SpaceWidth(),
                                  Text(
                                    'akkauntni_o’chirish'.tr(),
                                    style: const TextStyle(
                                        color: Color(0xFFFF0000),
                                        fontSize: AppSizes.size_16,
                                        fontWeight: AppFontWeight.w_600),
                                  )
                                ],
                              )),
                        ),
                        SpaceHeight(height: 15.h),
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              debugPrint('hello');
                              debugPrint(StorageRepository.getBool(
                                      Keys.isTemporaryUser)
                                  .toString());
                              if (!StorageRepository.getBool(
                                  Keys.isTemporaryUser)) {
                                widget.profileBloc.add(ChangeUserDataEvent(
                                    name: _nameController.text,
                                    gender: selectedChipIndex == 1
                                        ? 'erkak'
                                        : 'ayol',
                                    phone: _phoneController.text));
                                Navigator.pop(context);
                              } else {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        const PasswordBottomSheet());
                              }
                            }
                            if (StorageRepository.getBool(
                                Keys.isTemporaryUser)) {
                              /// password qoldi
                              isRegistered = true;
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('royxatdan_otmagansiz'.tr())));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            fixedSize: Size(double.infinity, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              isRegistered
                                  ? 'royxatdan_otish'.tr()
                                  : 'saqlash'.tr(),
                              style: const TextStyle(
                                  fontSize: AppSizes.size_16,
                                  color: Colors.white,
                                  fontWeight: AppFontWeight.w_600),
                            ),
                          ),
                        ),
                      ])),
            );
            // }
            // return Loading();
          },
        ));
  }
}
