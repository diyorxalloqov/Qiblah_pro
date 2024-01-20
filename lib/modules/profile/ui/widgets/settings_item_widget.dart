import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SettingsItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final String icon;
  const SettingsItemWidget(
      {super.key,
      required this.onTap,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(icon, width: 24, color: greyColor),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF293138),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: SmallText(text: subtitle),
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}
