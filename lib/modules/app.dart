import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiblah_pro/modules/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
  }
}
