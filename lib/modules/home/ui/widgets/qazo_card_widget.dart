import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class QazoCardWidget extends StatelessWidget {
  final String title;
  final String qazoCount;
  final Color color;
  final VoidCallback increment;
  final VoidCallback decrement;

  const QazoCardWidget(
      {super.key,
      required this.qazoCount,
      required this.color,
      required this.title,
      required this.decrement,
      required this.increment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: he(52),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: context.isDark ? Colors.black : Colors.white),
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
      child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          contentPadding: EdgeInsets.only(right: 16.w),
          leading: Container(
            height: 18,
            margin: const EdgeInsets.only(left: 16),
            width: 18,
            decoration:
                ShapeDecoration(color: color, shape: const OvalBorder()),
          ),
          title: Text(
            title,
            style:  TextStyle(
                fontSize: AppSizes.size_16, fontWeight: AppFontWeight.w_500),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: decrement,
                borderRadius: BorderRadius.circular(100.r),
                child: CircleAvatar(
                  backgroundColor: context.isDark
                      ? circleAvatarBlackColor
                      : circleAvatarColor,
                  child: const Center(
                      child: Text(
                    '-',
                    style: TextStyle(fontSize: 25),
                  )),
                ),
              ),
              SpaceWidth(width: 10.w),
              Text(
                qazoCount,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SpaceWidth(width: 10.w),
              InkWell(
                onTap: increment,
                borderRadius: BorderRadius.circular(100.r),
                child: CircleAvatar(
                  backgroundColor: context.isDark
                      ? circleAvatarBlackColor
                      : circleAvatarColor,
                  child: const Center(
                      child: Text(
                    '+',
                    style: TextStyle(fontSize: 25),
                  )),
                ),
              )
            ],
          )),
    );
  }
}
