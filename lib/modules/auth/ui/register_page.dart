import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  String dialCode = '+998';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.green.shade100,
                  Colors.lightGreen.shade50,
                  Colors.green.shade50
                ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
                child: Row(
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
                        radius: 88.r,
                        backgroundColor: Colors.white,
                        child: Center(child: Image.asset(AppImages.appLogo))),
                    GestureDetector(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, 'bottomNavbar', (route) => false),
                        child: SvgPicture.asset(AppIcon.cancel))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                height: context.height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighText(text: 'royxatdan_otish'.tr()),
                      const SpaceHeight(),
                      Text(
                        "royxatdan_otish_promt".tr(),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SpaceHeight(height: 25.h),
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
                              inputFormatters: [
                                MaskTextInputFormatter(
                                  mask: '+000 00 000 00 00',
                                  filter: {'0': RegExp(r'[0-9]')},
                                )
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                prefixIcon: TextButton(
                                    onPressed: () async {
                                      final picked = await countryPicker
                                          .showPicker(context: context);
                                      dialCode = picked?.dialCode ?? '+998';
                                      setState(() {});
                                    },
                                    child: Text(
                                      dialCode,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )),
                                hintText: 'telefon_raqam'.tr(),
                                hintStyle: TextStyle(
                                  fontSize: AppSizes.size_16,
                                  fontWeight: AppFontWeight.w_400,
                                  color: textFormFieldHintColor,
                                ),
                                fillColor: textFormFieldFillColor,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    style: BorderStyle.solid,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                            SpaceHeight(height: 15.h),
                            SmallText(text: 'parol'.tr()),
                            const SpaceHeight(),
                            TextFormField(
                              focusNode: _focusNode,
                              controller: _passwordController,
                              obscureText: passwordVisibile,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                  suffixIcon: Visibility(
                                      child: IconButton(
                                          onPressed: () {
                                            passwordVisibile =
                                                !passwordVisibile;
                                            setState(() {});
                                          },
                                          icon: passwordVisibile
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility))),
                                  fillColor: textFormFieldFillColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: AppSizes.size_16,
                                    fontWeight: AppFontWeight.w_400,
                                    color: textFormFieldHintColor,
                                  ),
                                  hintText: "Password"),
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
                            )
                          ],
                        ),
                      ),
                      SpaceHeight(height: 15.h),
                      ElevatedButton(
                          onPressed: () async {
                            // await StorageRepository.deleteBool(
                            //     Keys.isOnboarding);
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'bottomNavbar', (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              fixedSize: Size(double.infinity, 50.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r))),
                          child: Center(
                            child: Text(
                              "royxatdan_otish".tr(),
                              style: TextStyle(
                                  color: buttonNameColor,
                                  fontFamily: AppfontFamily.inter.fontFamily,
                                  fontSize: AppSizes.size_16,
                                  fontWeight: AppFontWeight.w_600),
                            ),
                          )),
                      const SpaceHeight(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'profilingiz_bormi'.tr(),
                              style: const TextStyle(
                                color: Color(0xFF1D2124),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        child: Center(
                            child: SmallText(text: 'orqali_kirish'.tr())),
                      ),
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
                                child: SvgPicture.asset(AppIcon.telegram)),
                          ),
                          Platform.isIOS
                              ? GestureDetector(
                                  onTap: () async {},
                                  child: CircleAvatar(
                                      backgroundColor: anotherSignInColor,
                                      child: SvgPicture.asset(AppIcon.apple)),
                                )
                              : const SizedBox(),
                        ],
                      )
                    ]),
              ),
            ],
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

//   Future<void> _handleFacebookLogin(BuildContext context) async {
//     try {
//       LoginResult accessToken = await FacebookAuth.instance.login();

//       // Check if the login was successful
//       if (accessToken != null) {
//         print('Facebook Auth Token: ${accessToken.accessToken}');
//         // Handle successful registration
//       } else {
//         print('Facebook Login Failed');
//         // Handle error
//       }
//     } catch (error) {
//       print('Facebook Login Error: $error');
//       // Handle error
//     }
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
