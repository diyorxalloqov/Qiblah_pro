import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileBloc profileBloc;
  const EditProfilePage({super.key, required this.profileBloc});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _phoneController;
  late TextEditingController _nameController;

  int selectedChipIndex = StorageRepository.getBool(Keys.isMan) ? 1 : 0;
  final List<String> _titles = const ['ayol', "erkak"];
  final List<String> _icons = const [AppIcon.woman, AppIcon.man];

  @override
  void initState() {
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  String dialCode = '+998';
  bool isMan = true;

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
                                  onPressed: () {},
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
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => showAdaptiveDialog(
                          context: context,
                          builder: (context) => ImagePickerWidget(
                                imageOntap: () {
                                  widget.profileBloc.add(const GetimageEvent());
                                  Navigator.pop(context);
                                },
                                profileBloc: widget.profileBloc,
                              )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                  width: 100.r,
                                  height: 100.r,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(widget
                                            .profileBloc.state.imagePath))),
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
                                  child: const Icon(Icons.person_rounded,
                                      color: Colors.white, size: 42)),
                              Positioned(
                                  top: 30,
                                  left: 65,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: Colors.white),
                                      child: SvgPicture.asset(AppIcon.camera))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SpaceHeight(height: 20.h),
                    SmallText(text: 'ismingiz_nima'.tr()),
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
                            color: textFormFieldHintColor,
                          ),
                          fillColor: context.isDark
                              ? textFormFieldFillColorBlack
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: context.isDark
                                ? BorderSide.none
                                : const BorderSide(
                                    color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: context.isDark
                                ? BorderSide.none
                                : const BorderSide(
                                    color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    SpaceHeight(height: 25.h),
                    SmallText(text: 'telefon_raqamingiz'.tr()),
                    const SpaceHeight(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            // MaskTextInputFormatter(
                            //   mask: '+000 00 000 00 00',
                            //   filter: {'0': RegExp(r'[0-9]')},
                            // )
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'telefon_raqam'.tr(),
                            hintStyle: TextStyle(
                              fontSize: AppSizes.size_16,
                              fontWeight: AppFontWeight.w_400,
                              color: textFormFieldHintColor,
                            ),
                            prefixIcon: TextButton(
                                onPressed: () async {
                                  final picked = await countryPicker.showPicker(
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
                                  : const BorderSide(
                                      color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: context.isDark
                                  ? BorderSide.none
                                  : const BorderSide(
                                      color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        SpaceHeight(height: 24.h),
                        SizedBox(
                          height: 60.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(2, (index) {
                              return ChoiceChip(
                                backgroundColor: context.isDark
                                    ? jinsBlackColor
                                    : Colors.white,
                                label: SizedBox(
                                  height: 45.h,
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
                                  print(value);
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
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (c) =>
                                    const EditPasswordBottomSheet());
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            height: context.height * 0.07,
                            decoration: BoxDecoration(
                                color: smallTextColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppIcon.key),
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
                                                      onPressed: () {},
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
                                      fontWeight: AppFontWeight.w_600,
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SpaceHeight(height: 15.h),
                        ElevatedButton(
                          onPressed: () async {
                            await StorageRepository.putBool(Keys.isMan, isMan);
                            await StorageRepository.putString(
                                Keys.name, _nameController.text);
                            Navigator.pop(context);
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
                              'saqlash'.tr(),
                              style: const TextStyle(
                                fontSize: AppSizes.size_16,
                                color: Colors.white,
                                fontWeight: AppFontWeight.w_600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ])),
        ));
  }
}
