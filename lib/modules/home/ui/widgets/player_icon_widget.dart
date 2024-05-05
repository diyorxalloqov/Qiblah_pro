import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class PlayerIcon extends StatelessWidget {
  final VoidCallback onTap;
  final Color backColor;
  final Widget icon;
  const PlayerIcon(
      {super.key,
      required this.backColor,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 16.r,
      child: CircleAvatar(
        radius: 16.r,
        backgroundColor: backColor,
        child: Center(child: icon),
      ),
    );
  }
}
