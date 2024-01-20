import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class EditPasswordBottomSheet extends StatefulWidget {
  const EditPasswordBottomSheet({super.key});

  @override
  State<EditPasswordBottomSheet> createState() =>
      _EditPasswordBottomSheetState();
}

class _EditPasswordBottomSheetState extends State<EditPasswordBottomSheet>
    with WidgetsBindingObserver {
  late GlobalKey<FormState> _key;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newpasswordController;
  late TextEditingController _confirmNewpasswordController;

  bool _isKeyboardAppear = false;
  bool _isTextFieldFocused = false;
  bool prefix = false;
  late FocusNode _focusNode;
  bool oldpasswordVisibile = false;
  bool newpassconfirmVisible = false;
  bool confirmpassconfirmVisible = false;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }

    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return "Parolda kamida bitta harf qatnashishi kerak";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Parolda kamida bitta son qatnashishi kerak";
    }

    return null;
  }

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newpasswordController = TextEditingController();
    _confirmNewpasswordController = TextEditingController();
    _focusNode = FocusNode();

    _key = GlobalKey<FormState>();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        prefix = true;
      } else {
        prefix = false;
      }
      setState(() {});
    });
    WidgetsBinding.instance.addObserver(this);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    super.initState();
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: MediumText(text: 'parolni_ozgartirish'.tr()),
        ),
        Container(
          height: _isKeyboardAppear || _isTextFieldFocused
              ? context.height
              : context.height * 0.6,
          color: scaffoldColor,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(text: 'eski_parolni_kiriting'.tr()),
              const SpaceHeight(),
              TextFormField(
                focusNode: _focusNode,
                controller: _oldPasswordController,
                obscureText: oldpasswordVisibile,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    suffixIcon: Visibility(
                        child: IconButton(
                            onPressed: () {
                              oldpasswordVisibile = !oldpasswordVisibile;
                              setState(() {});
                            },
                            icon: oldpasswordVisibile
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off))),
                    fillColor: const Color(0xffF4F8FA),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                            color: greyColor.withOpacity(0.3), width: 1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB5B9BC),
                    ),
                    hintText: "eski_parolni_kiriting".tr()),
                validator: (value) {
                  String? passwordError = validatePassword(value);
                  // if (value == null) {
                  //   return "Iltimos bo'sh qoldirmang";
                  // } else if (value.length < 4) {
                  //   return "Parol 4 ta belgidan kam bo'lmasligi kerak";
                  // } else if (passwordError != null) {
                  //   return passwordError;
                  // } else if (value.length > 16) {
                  //   return "Parol yaroqsiz";
                  // } else {
                  //   return null;
                  // }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const Divider(),
              ),
              SmallText(text: 'yangi_parolni_kiriting'.tr()),
              const SpaceHeight(),
              TextFormField(
                focusNode: _focusNode,
                controller: _newpasswordController,
                obscureText: newpassconfirmVisible,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    suffixIcon: Visibility(
                        child: IconButton(
                            onPressed: () {
                              newpassconfirmVisible = !newpassconfirmVisible;
                              setState(() {});
                            },
                            icon: newpassconfirmVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off))),
                    fillColor: const Color(0xffF4F8FA),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                            color: greyColor.withOpacity(0.3), width: 1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB5B9BC),
                    ),
                    hintText: "yangi_parolni_kiriting".tr()),
                validator: (value) {
                  String? passwordError = validatePassword(value);
                  // if (value == null) {
                  //   return "Iltimos bo'sh qoldirmang";
                  // } else if (value.length < 4) {
                  //   return "Parol 4 ta belgidan kam bo'lmasligi kerak";
                  // } else if (passwordError != null) {
                  //   return passwordError;
                  // } else if (value.length > 16) {
                  //   return "Parol yaroqsiz";
                  // } else {
                  //   return null;
                  // }
                },
              ),
              SpaceHeight(height: 23.h),
              SmallText(text: 'yangi_parolni_takrorlang'.tr()),
              const SpaceHeight(),
              TextFormField(
                focusNode: _focusNode,
                controller: _confirmNewpasswordController,
                obscureText: confirmpassconfirmVisible,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    suffixIcon: Visibility(
                        child: IconButton(
                            onPressed: () {
                              confirmpassconfirmVisible =
                                  !confirmpassconfirmVisible;
                              setState(() {});
                            },
                            icon: confirmpassconfirmVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off))),
                    fillColor: const Color(0xffF4F8FA),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                            color: greyColor.withOpacity(0.3), width: 1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB5B9BC),
                    ),
                    hintText: "yangi_parolni_takrorlang".tr()),
                validator: (value) {
                  String? passwordError = validatePassword(value);
                  // if (value == null) {
                  //   return "Iltimos bo'sh qoldirmang";
                  // } else if (value.length < 4) {
                  //   return "Parol 4 ta belgidan kam bo'lmasligi kerak";
                  // } else if (passwordError != null) {
                  //   return passwordError;
                  // } else if (value.length > 16) {
                  //   return "Parol yaroqsiz";
                  // } else {
                  //   return null;
                  // }
                },
              ),
              SpaceHeight(height: 23.h),
              ElevatedButton(
                onPressed: () async {
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
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
