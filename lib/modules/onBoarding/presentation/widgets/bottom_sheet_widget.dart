import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class BottomSheetWidget extends StatefulWidget {
  final PageController pageController;

  const BottomSheetWidget({super.key, required this.pageController});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with WidgetsBindingObserver {
  int selectedChipIndex = -1;
  final List<String> _titles = const ['ayol', "erkak"];
  final List<String> _icons = const [AppIcon.woman, AppIcon.man];
  bool _isKeyboardAppear = false;
  bool _isTextFieldFocused = false;
  late FocusNode _focusNode;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isTextFieldFocused = _focusNode.hasFocus;
      if (!_isTextFieldFocused) {
        _isKeyboardAppear = false;
      }
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (_isKeyboardAppear && MediaQuery.of(context).viewInsets.bottom == 0) {
      setState(() {
        _isKeyboardAppear = false;
      });
    }
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isMan = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        _isKeyboardAppear = false;
        _isTextFieldFocused = false;
      },
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: context.isDark ? containerBlackColor : containerColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r))),
          width: double.infinity,
          height: _isKeyboardAppear || _isTextFieldFocused ? 750.h : 520.h,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighText(text: 'keling_tanishib_olamiz:'.tr()),
              SpaceHeight(height: 20.h),
              SmallText(text: 'ismingiz_nima'.tr()),
              Form(
                key: _key,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: TextFormField(
                    onTap: () {
                      setState(() {
                        _isKeyboardAppear = true;
                      });
                    },
                    focusNode: _focusNode,
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
                          : textFormFieldFillColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: context.isDark
                            ? BorderSide.none
                            : const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Iltimos ismingizni kiriting';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SmallText(text: 'jins_promt'.tr()),
              const SpaceHeight(),
              SizedBox(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(2, (index) {
                    return ChoiceChip(
                      backgroundColor:
                          context.isDark ? jinsBlackColor : jinsColor,
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
                      // backgroundColor: bottomSheetBackgroundColor,
                      selectedColor: primaryColor.withOpacity(0.2),
                      disabledColor: textFormFieldHintColor,
                      onSelected: (value) {
                        setState(() {
                          index == 0 ? isMan = false : isMan = true;
                          print(isMan);
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
              const SpaceHeight(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        print(isMan);
                        await StorageRepository.putString(
                            Keys.name, _nameController.text);
                        await StorageRepository.putBool(Keys.isMan, isMan);

                        Navigator.pop(context);
                        widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      fixedSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Text(
                          'btn_davom_etish'.tr(),
                          style: AppfontFamily.inter.copyWith(
                              fontSize: AppSizes.size_16,
                              color: buttonNameColor,
                              fontWeight: AppFontWeight.w_600),
                        ),
                        SvgPicture.asset(AppIcon.arrowRight),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
