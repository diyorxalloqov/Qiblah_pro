import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamozDetailsCardWidget extends StatelessWidget {
  final String title;
  final int index;
  final VoidCallback onTap;
  const NamozDetailsCardWidget(
      {super.key,
      required this.title,
      required this.index,
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
        leading: Container(
          width: 28,
          height: 28,
          decoration: ShapeDecoration(
            color: primaryColor,
            shape: const StarBorder(
              points: 8,
              innerRadiusRatio: 0.84,
            ),
          ),
          child: Center(
              child: Text(
            '$index',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: AppFontWeight.w_500),
          )),
        ),
        title: Text(
          title,
          style: TextStyle(
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
