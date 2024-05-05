import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamozCardWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;
  const NamozCardWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0,
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        onTap: onTap,
        leading: icon,
        title: Text(
          title,
          style:  TextStyle(
            fontSize: AppSizes.size_16,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            color: smallTextColor, size: 18),
      ),
    );
  }
}
