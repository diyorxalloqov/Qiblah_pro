import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

showDialog(BuildContext c) {
  showAdaptiveDialog(
      context: c, builder: (c) => const LogOutAndDeleteAccDialog());
}

class LogOutAndDeleteAccDialog extends StatelessWidget {
  const LogOutAndDeleteAccDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      
    );
  }
}
