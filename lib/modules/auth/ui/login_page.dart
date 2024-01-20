import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 126.w, vertical: 32.h),
                decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                  Colors.green.shade100,
                  Colors.lightGreen.shade50,
                  Colors.green.shade50
                ])),
                child: Center(
                  child: CircleAvatar(
                    radius: 90.r,
                    backgroundColor: Colors.white,
                    child: const Center(child: Text("Logo")),
                  ),
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
                      HighText(text: 'kirish'.tr()),
                      const SpaceHeight(),
                      Text("kirish_promt".tr()),
                      SpaceHeight(height: 25.h),
                      SmallText(text: 'telefon_raqamingiz'.tr()),
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
                                hintText: 'telefon_raqam'.tr(),
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffB5B9BC),
                                ),
                                fillColor: const Color(0xffF4F8FA),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      style: BorderStyle.solid,
                                      width: 0.5,
                                      color: Colors.red),
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
                                  fillColor: const Color(0xffF4F8FA),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffB5B9BC),
                                  ),
                                  hintText: "parol".tr()),
                              validator: (value) {
                                String? passwordError = validatePassword(value);
                                if (value == null) {
                                  return "Iltimos bo'sh qoldirmang";
                                } else if (value.length < 4) {
                                  return "Parol 4 ta belgidan kam bo'lmasligi kerak";
                                } else if (passwordError != null) {
                                  return passwordError;
                                } else if (value.length > 16) {
                                  return "Parol yaroqsiz";
                                } else {
                                  return null;
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SpaceHeight(height: 15.h),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              fixedSize: Size(double.infinity, 50.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r))),
                          child: Center(
                            child: Text(
                              "kirish".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                      const SpaceHeight(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'profilingiz_yoqmi'.tr(),
                              style: const TextStyle(
                                color: Color(0xFF1D2124),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, 'register'),
                              child: Text(
                                'royxatdan_otish'.tr(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
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
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(AppIcon.facebook)),
                          ),
                          GestureDetector(
                            onTap: () => _googleSignIn(context),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(AppIcon.google)),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(AppIcon.yandex)),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(AppIcon.telegram)),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(AppIcon.apple)),
                          ),
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
      await googleSignIn.signIn();
    } catch (error) {
      print('Google Sign-In Error: $error');
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
