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
      leading: SvgPicture.asset(icon,
          width: 24,
          color:
              context.isDark ? Colors.white.withOpacity(0.5) : smallTextColor),
      title: Text(
        title,
        style: TextStyle(
          color: context.isDark ? Colors.white : Colors.black,
          fontSize: AppSizes.size_16,
          fontWeight: AppFontWeight.w_500,
        ),
      ),
      subtitle: SmallText(text: subtitle),
      trailing:
          const Icon(Icons.keyboard_arrow_right, color: Color(0xff6D7379)),
    );
  }
}
