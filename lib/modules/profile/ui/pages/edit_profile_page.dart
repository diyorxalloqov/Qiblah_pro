import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/global/widgets/custom_app_bar.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileBloc profileBloc;
  const EditProfilePage({super.key, required this.profileBloc});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _phoneController;

  int selectedChipIndex = 0;
  final List<String> _titles = const ['ayol', "erkak"];
  final List<String> _icons = const [AppIcon.woman, AppIcon.man];

  @override
  void initState() {
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(
          context,
          "profilni_tahrirlash".tr(),
          icon1: AppIcon.logout,
          onTap1: () {},
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
                                    shape: OvalBorder(),
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
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'ismingizni_yozing'.tr(),
                          hintStyle: TextStyle(
                            fontSize: AppSizes.size_16,
                            fontWeight: AppFontWeight.w_400,
                            color: textFormFieldHintColor,
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.white70,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.white70,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
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
                            MaskTextInputFormatter(
                              mask: '+000 00 000 00 00',
                              filter: {'0': RegExp(r'[0-9]')},
                            )
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'telefon_raqam'.tr(),
                            hintStyle: TextStyle(
                              fontSize: AppSizes.size_16,
                              fontWeight: AppFontWeight.w_400,
                              color: textFormFieldHintColor,
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white70),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0.5, color: highTextColor),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                        SpaceHeight(height: 24.h),
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
                                      style: TextStyle(
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
                              backgroundColor: Colors.white,
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
                        Center(
                          child: TextButton(
                              onPressed: () {},
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
                        )
                      ],
                    )
                  ])),
        ));
  }
}
