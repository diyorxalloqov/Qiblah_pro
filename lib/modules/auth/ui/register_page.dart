import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qiblah_pro/modules/auth/bloc/auth_bloc.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late GlobalKey<FormState> _key;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  bool prefix = false;

  final FocusNode _focusNode = FocusNode();

  bool passwordVisibile = true;
  bool passconfirmVisible = true;

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
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        prefix = true;
      } else {
        prefix = false;
      }
      setState(() {});
    });
    super.initState();
  }

  String dialCode = '+998';
  String countryCode = 'uz';

  @override
  Widget build(BuildContext context) {
    final FlCountryCodePicker countryPicker = FlCountryCodePicker(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'davlatni_tanlang'.tr(),
          style: const TextStyle(
              fontSize: AppSizes.size_20, fontWeight: AppFontWeight.w_500),
        ),
      ),
      searchBarDecoration: InputDecoration(
        filled: true,
        hintText: 'davlatni_tanlang'.tr(),
        hintStyle: TextStyle(
          fontSize: AppSizes.size_16,
          fontWeight: AppFontWeight.w_400,
          color: textFormFieldHintColor,
        ),
        fillColor: context.isDark
            ? textFormFieldFillColorBlack
            : textFormFieldFillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: context.isDark ? const Color(0xff153125) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: context.height,
            width: context.width,
            padding: EdgeInsets.only(top: 31.h),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: context.isDark
                        ? loginRegisterBlackGradient
                        : loginRegisterGradient,
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        SpaceWidth(),
                        SpaceWidth(),
                        SpaceWidth(),
                        SpaceWidth(),
                      ],
                    ),
                    CircleAvatar(
                        radius: 61.r,
                        backgroundColor: context.isDark
                            ? const Color(0xff232C37)
                            : Colors.white,
                        child: Center(
                            child: SvgPicture.asset(AppIcon.appLogo,
                                width: 40.w))),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state.status1 == ActionStatus.isSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'bottomNavbar', (route) => false);
                        } else if (state.status1 == ActionStatus.isError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return GestureDetector(
                              onTap: () {
                                context.read<AuthBloc>().add(
                                    RegisterTemporaryEvent(
                                        countryCode: countryCode));
                              },
                              child: state.status1 == ActionStatus.isLoading
                                  ? Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: context.isDark
                                              ? Colors.black
                                              : Colors.white),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child:
                                            CircularProgressIndicator.adaptive(
                                                backgroundColor: Colors.blue),
                                      ))
                                  : SvgPicture.asset(context.isDark
                                      ? AppIcon.cancelBlack
                                      : AppIcon.cancel));
                        },
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 28.h),
                      decoration: BoxDecoration(
                        color: context.isDark
                            ? bottomSheetBackgroundBlackColor
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HighText(text: 'royxatdan_otish'.tr()),
                            const SpaceHeight(),
                            SmallText(text: "royxatdan_otish_promt".tr()),
                            SpaceHeight(height: 20.h),
                            SmallText(text: 'telefon_raqam'.tr()),
                            const SpaceHeight(),
                            Form(
                              key: _key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.number,
                                    // inputFormatters: [
                                    //   MaskTextInputFormatter(
                                    //     mask: '00 000 00 00',
                                    //     filter: {'0': RegExp(r'[0-9]')},
                                    //   )
                                    // ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: wi(16)),
                                      constraints:
                                          BoxConstraints(maxHeight: he(48)),
                                     fillColor: context.isDark
                                      ? textFormFieldFillColorBlack
                                      : const Color(0xffF5F4FA),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: context.isDark
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Color(0xffE3E7EA),
                                                width: 1),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: context.isDark
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Color(0xffE3E7EA),
                                                width: 1),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: context.isDark
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Color(0xffE3E7EA),
                                                width: 1),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      prefixIcon: TextButton(
                                          onPressed: () async {
                                            final picked =
                                                await countryPicker.showPicker(
                                              context: context,
                                              backgroundColor: context.isDark
                                                  ? bottomSheetBackgroundBlackColor
                                                  : bottomSheetBackgroundColor,
                                            );
                                            dialCode =
                                                picked?.dialCode ?? '+998';
                                            countryCode = picked?.code ?? 'UZ';
                                            setState(() {});
                                          },
                                          child: Text(
                                            dialCode,
                                            style: TextStyle(
                                                color: context.isDark
                                                    ? Colors.white
                                                    : Colors.black),
                                          )),
                                      hintText: 'telefon_raqam'.tr(),
                                      hintStyle: TextStyle(
                                        fontSize: he(AppSizes.size_16),
                                        fontWeight: AppFontWeight.w_400,
                                        color: textFormFieldHintColor,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "validator_prop".tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  SpaceHeight(height: 24.h),
                                  SmallText(text: 'parol'.tr()),
                                  const SpaceHeight(),
                                  TextFormField(
                                    focusNode: _focusNode,
                                    controller: _passwordController,
                                    obscureText: passwordVisibile,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: wi(16)),
                                        constraints:
                                            BoxConstraints(maxHeight: he(48)),
                                        fillColor: context.isDark
                                            ? textFormFieldFillColorBlack
                                            : const Color(0xffF5F4FA),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: context.isDark
                                              ? BorderSide.none
                                              : const BorderSide(
                                                  color: Color(0xffE3E7EA),
                                                  width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: context.isDark
                                              ? BorderSide.none
                                              : const BorderSide(
                                                  color: Color(0xffE3E7EA),
                                                  width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: context.isDark
                                              ? BorderSide.none
                                              : const BorderSide(
                                                  color: Color(0xffE3E7EA),
                                                  width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12.0.r),
                                        ),
                                        suffixIcon: Visibility(
                                            child: IconButton(
                                                onPressed: () {
                                                  passwordVisibile =
                                                      !passwordVisibile;
                                                  setState(() {});
                                                },
                                                icon: passwordVisibile
                                                    ? const Icon(
                                                        Icons.visibility_off,
                                                        color:
                                                            Color(0xff6D7379))
                                                    : const Icon(
                                                        Icons.visibility,
                                                        color: Color(
                                                            0xff6D7379)))),
                                        hintStyle: TextStyle(
                                          fontSize: he(AppSizes.size_16),
                                          fontWeight: AppFontWeight.w_400,
                                          color: textFormFieldHintColor,
                                        ),
                                        hintText: "parol".tr()),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Iltimos bo'sh qoldirmang";
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ),
                            SpaceHeight(height: 26.h),
                            BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                state.status == ActionStatus.isSuccess
                                    ? Navigator.pushNamedAndRemoveUntil(context,
                                        'bottomNavbar', (route) => false)
                                    : null;
                                if (state.status == ActionStatus.isError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: context.isDark
                                              ? Colors.white
                                              : Colors.black,
                                          content: Text(state.error)));
                                }
                              },
                              child: BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                      onPressed: () async {
                                        if (_key.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                              RegisterEvent('not have',
                                                  countryCode: countryCode,
                                                  phoneNumber:
                                                      _phoneController.text,
                                                  password: _passwordController
                                                      .text));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          fixedSize:
                                              Size(double.infinity, 50.h),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r))),
                                      child: Center(
                                        child: state.status ==
                                                ActionStatus.isLoading
                                            ? const CircularProgressIndicator
                                                .adaptive(
                                                backgroundColor: Colors.white)
                                            : Text(
                                                "royxatdan_otish".tr(),
                                                style: TextStyle(
                                                    color: buttonNameColor,
                                                    fontFamily: AppfontFamily
                                                        .inter.fontFamily,
                                                    fontSize:
                                                        he(AppSizes.size_16),
                                                    fontWeight:
                                                        AppFontWeight.w_600)),
                                      ));
                                },
                              ),
                            ),
                            SpaceHeight(height: 12.h),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'profilingiz_bormi'.tr(),
                                    style: TextStyle(
                                      color: context.isDark
                                          ? Colors.white
                                          : const Color(0xFF1D2124),
                                      fontSize: AppSizes.size_16,
                                      fontWeight: AppFontWeight.w_600,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        Navigator.pushNamed(context, 'login'),
                                    child: Text(
                                      'kirish'.tr(),
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: AppSizes.size_16,
                                        fontWeight: AppFontWeight.w_600,
                                      ),
                                    ),
                                  ),
                                ]),
                            SpaceHeight(height: 12.h),
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                const SpaceWidth(),
                                const SpaceWidth(),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 7.h),
                                    child: Center(
                                        child: SmallText(
                                            text: 'orqali_kirish'.tr()))),
                                const SpaceWidth(),
                                const SpaceWidth(),
                                const Expanded(child: Divider())
                              ],
                            ),
                            SpaceHeight(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // GestureDetector(
                                //   onTap: () {},
                                //   child: CircleAvatar(
                                //       backgroundColor: anotherSignInColor,
                                //       child: SvgPicture.asset(AppIcon.facebook)),
                                // ),
                                const SizedBox(),
                                GestureDetector(
                                  onTap: () => _googleSignIn(context),
                                  child: CircleAvatar(
                                      backgroundColor: anotherSignInColor,
                                      child: SvgPicture.asset(AppIcon.google)),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                      backgroundColor: anotherSignInColor,
                                      child: SvgPicture.asset(AppIcon.yandex)),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                      backgroundColor: anotherSignInColor,
                                      child:
                                          SvgPicture.asset(AppIcon.telegram)),
                                ),
                                Platform.isIOS
                                    ? GestureDetector(
                                        onTap: () async {},
                                        child: CircleAvatar(
                                            backgroundColor: anotherSignInColor,
                                            child: SvgPicture.asset(
                                                AppIcon.apple)),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SpaceHeight(),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _googleSignIn(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        // Signed in successfully, now obtain the authentication tokens
        final GoogleSignInAuthentication googleAuth =
            await account.authentication;
        String? accessToken = googleAuth.accessToken;
        String? idToken = googleAuth.idToken;
        print(account.displayName);
        print(account.email);
        print(account.id);

        // Use accessToken and idToken as needed
        print('Access Token: $accessToken');
        print('ID Token: $idToken');
      } else {
        // User canceled the sign-in process
        print('Google Sign-In canceled');
      }
    } on PlatformException catch (error) {
      print('Google Sign-In Error: $error');
      // Handle sign-in errors here
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_telegram_login/flutter_telegram_login.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('User Registration'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
            
//               ElevatedButton(
//                 onPressed: () => _handleTelegramLogin(context),
//                 child: Text('Register with Telegram'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _handleFacebookLogin(context),
//                 child: Text('Register with Facebook'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _handleAppleSignIn(context),
//                 child: Text('Register with Apple'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _handleYandexLogin(context),
//                 child: Text('Register with Yandex'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }



//   Future<void> _handleTelegramLogin(BuildContext context) async {
//     // try {
//     // TelegramLoginResult result = await FlutterTelegramLogin.login(
//     //   botToken: 'YOUR_BOT_TOKEN',
//     // );

//     //   if (result.success) {
//     //     print('Telegram Auth ID: ${result.data}');
//     //     // Handle successful registration
//     //   } else {
//     //     print('Telegram Auth Failed');
//     //     // Handle error
//     //   }
//     // } catch (error) {
//     //   print('Telegram Login Error: $error');
//     //   // Handle error
//     // }
//   }



//   Future<void> _handleAppleSignIn(BuildContext context) async {
//     // try {
//     //   final result = await SignInWithApple.getAuthorizationResult();

//     //   // Check if the login was successful
//     //   if (result.status == AuthorizationStatus.authorized) {
//     //     print('Apple Auth ID: ${result.credential.userIdentifier}');
//     //     // Handle successful registration
//     //   } else {
//     //     print('Apple Sign-In Failed');
//     //     // Handle error
//     //   }
//     // } catch (error) {
//     //   print('Apple Sign-In Error: $error');
//     //   // Handle error
//     // }
//   }

//   Future<void> _handleYandexLogin(BuildContext context) async {
//     // Implement Yandex authentication using OAuth or other relevant method
//     // Handle successful registration or error accordingly
//   }
// }
