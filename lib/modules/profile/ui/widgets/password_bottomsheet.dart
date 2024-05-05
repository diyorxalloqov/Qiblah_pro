import 'package:qiblah_pro/modules/auth/bloc/auth_bloc.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/utils/extension/internet_checker.dart';

class PasswordBottomSheet extends StatefulWidget {
  final String countryCode;
  final TextEditingController phoneController;
  const PasswordBottomSheet(
      {super.key, required this.phoneController, required this.countryCode});

  @override
  State<PasswordBottomSheet> createState() => _PasswordBottomSheetState();
}

class _PasswordBottomSheetState extends State<PasswordBottomSheet>
    with WidgetsBindingObserver {
  late GlobalKey<FormState> _key;
  late TextEditingController _newpasswordController;
  late TextEditingController _confirmNewpasswordController;

  bool _isKeyboardAppear = false;
  bool _isTextFieldFocused = false;
  late FocusNode _focusNode;
  late FocusNode _focusNode1;
  bool newpassconfirmVisible = true;
  bool confirmpassconfirmVisible = true;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "validator_prop".tr();
    }

    // if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
    //   return "Parolda kamida bitta harf qatnashishi kerak";
    // }

    // if (!RegExp(r'[0-9]').hasMatch(value)) {
    //   return "Parolda kamida bitta son qatnashishi kerak";
    // }

    return null;
  }

  @override
  void initState() {
    _newpasswordController = TextEditingController();
    _confirmNewpasswordController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode1 = FocusNode();
    _key = GlobalKey<FormState>();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_onFocusChange);
    _focusNode1.addListener(_onFocusChange1);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode1.removeListener(_onFocusChange1);
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

  void _onFocusChange1() {
    setState(() {
      _isTextFieldFocused = _focusNode1.hasFocus;
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
            color: context.isDark
                ? bottomSheetBackgroundBlackColor
                : bottomSheetBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: MediumText(text: 'parol_ornatish'.tr()),
        ),
        const SpaceHeight(),
        Container(
          height: _isKeyboardAppear || _isTextFieldFocused
              ? context.height * 0.7
              : null,
          color: context.isDark
              ? bottomSheetBackgroundBlackColor
              : bottomSheetBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(text: 'yangi_parolni_kiriting'.tr()),
                  const SpaceHeight(),
                  TextFormField(
                    focusNode: _focusNode,
                    controller: _newpasswordController,
                    obscureText: newpassconfirmVisible,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        suffixIcon: Visibility(
                            child: IconButton(
                                onPressed: () {
                                  newpassconfirmVisible =
                                      !newpassconfirmVisible;
                                  setState(() {});
                                },
                                icon: newpassconfirmVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility))),
                        filled: true,
                        fillColor: context.isDark
                            ? textFormFieldFillColorBlack
                            : Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: context.isDark
                              ? BorderSide.none
                              : const BorderSide(
                                  color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: context.isDark
                              ? BorderSide.none
                              : const BorderSide(
                                  color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: context.isDark
                              ? BorderSide.none
                              : const BorderSide(
                                  color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintStyle: TextStyle(
                          fontSize: AppSizes.size_16,
                          fontWeight: AppFontWeight.w_400,
                          color: textFormFieldHintColor,
                        ),
                        hintText: "yangi_parolni_kiriting".tr()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "validator_prop".tr();
                      } else if (value.length <= 6) {
                        return "password_valid".tr();
                      }
                      return null;
                    },
                  ),
                  SpaceHeight(height: 23.h),
                  SmallText(text: 'yangi_parolni_takrorlang'.tr()),
                  const SpaceHeight(),
                  TextFormField(
                    focusNode: _focusNode1,
                    controller: _confirmNewpasswordController,
                    obscureText: confirmpassconfirmVisible,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        suffixIcon: Visibility(
                            child: IconButton(
                                onPressed: () {
                                  confirmpassconfirmVisible =
                                      !confirmpassconfirmVisible;
                                  setState(() {});
                                },
                                icon: confirmpassconfirmVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility))),
                        filled: true,
                        fillColor: context.isDark
                            ? textFormFieldFillColorBlack
                            : Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: context.isDark
                              ? BorderSide.none
                              : const BorderSide(
                                  color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: context.isDark
                              ? BorderSide.none
                              : const BorderSide(
                                  color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: context.isDark
                              ? BorderSide.none
                              : const BorderSide(
                                  color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintStyle: TextStyle(
                          fontSize: AppSizes.size_16,
                          fontWeight: AppFontWeight.w_400,
                          color: textFormFieldHintColor,
                        ),
                        hintText: "yangi_parolni_takrorlang".tr()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "validator_prop".tr();
                      } else if (_newpasswordController.text != value) {
                        return "new_pasword".tr();
                      }
                      return null;
                    },
                  ),
                  SpaceHeight(height: 23.h),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.status == ActionStatus.isSuccess) {
                        showToastMessage('profile_changing'.tr(), context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else if (state.status == ActionStatus.isError) {
                        showToastMessage(state.error, context);
                      }
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (await context.hasInternet) {
                              if (_key.currentState!.validate()) {
                                context.read<AuthBloc>().add(RegisterEvent(
                                    'not have',
                                    countryCode: widget.countryCode,
                                    phoneNumber: widget.phoneController.text,
                                    password:
                                        _confirmNewpasswordController.text));
                              }
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
                            child: state.status == ActionStatus.isLoading
                                ? const CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white)
                                : Text(
                                    'saqlash'.tr(),
                                    style:  TextStyle(
                                      fontSize: AppSizes.size_16,
                                      color: Colors.white,
                                      fontWeight: AppFontWeight.w_600,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
