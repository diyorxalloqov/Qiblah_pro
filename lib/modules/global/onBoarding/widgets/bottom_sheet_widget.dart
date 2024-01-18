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
  final List<String> _titles = const ['Ayol', "Erkak"];
  final List<String> _icons = const [AppIcon.woman, AppIcon.man];
  bool _isKeyboardAppear = false;
  bool _isTextFieldFocused = false;
  late FocusNode _focusNode;

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: _isKeyboardAppear || _isTextFieldFocused ? 750.h : 470.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HighText(text: 'Keling tanishib olamiz:'),
            SpaceHeight(height: 30.h),
            const SmallText(text: 'Ismingiz nima?'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: TextFormField(
                onTap: () {
                  setState(() {
                    _isKeyboardAppear = true;
                  });
                },
                focusNode: _focusNode,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Ismingizni yozing',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffB5B9BC),
                  ),
                  fillColor: const Color(0xffF4F8FA),
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
            const SmallText(
              text: 'Namoz rasmlari mos ko’rsatilishi uchun jinsni tanlang:',
            ),
            const SpaceHeight(),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0,
              runSpacing: 4.0,
              children: List.generate(2, (index) {
                return ChoiceChip(
                  label: SizedBox(
                    height: 45.h,
                    width: 150.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(_icons[index]),
                        Text(
                          _titles[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  side: selectedChipIndex == index
                      ? BorderSide(color: primaryColor, width: 1)
                      : BorderSide.none,
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF4F8FA),
                  selectedColor: primaryColor.withOpacity(0.2),
                  disabledColor: const Color(0xffF4F8FA),
                  onSelected: (value) {
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
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
                      const Text(
                        'Davom etish',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
    );
  }
}
