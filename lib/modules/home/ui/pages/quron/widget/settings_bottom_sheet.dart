import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

showSettingBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) => const SettingsPage());
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r))),
    );
  }
}
