import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart'; // Import Flutter's widgets for BuildContext
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

extension ThemesData on BuildContext {
  Future<bool> get hasInternet async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
