import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TanlanganlarPage extends StatelessWidget {
  const TanlanganlarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemBuilder: (context, index) {
          return const TanlanganlarItem();
        });
  }
}

class TanlanganlarItem extends StatefulWidget {
  const TanlanganlarItem({super.key});

  @override
  State<TanlanganlarItem> createState() => _TanlanganlarItemState();
}

class _TanlanganlarItemState extends State<TanlanganlarItem> {
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Al baqara',
            style: TextStyle(
              color: context.isDark ? Colors.white : Colors.black,
              fontSize: AppSizes.size_16,
              fontFamily: AppfontFamily.comforta.fontFamily,
              fontWeight: AppFontWeight.w_700,
            ),
          ),
          const SpaceHeight(),
          Container(
            decoration: BoxDecoration(
                color: context.isDark
                    ? tanlanganlarItemBlackColor
                    : tanlanganlarItemColor,
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          Text(
                            ' الفاتحةالفاتحة',
                            style: TextStyle(
                              color: context.isDark
                                  ? arabicWhiteTextColor
                                  : arabicTextColor,
                              fontSize: AppSizes.arabicTextSize,
                              fontFamily: AppfontFamily.inter.fontFamily,
                              fontWeight: AppFontWeight.arabicFontWeight,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '1. Aliflammeem',
                        style: TextStyle(
                          fontSize: 16,
                          color: context.isDark ? Colors.white : Colors.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SpaceHeight(),
                      Text(
                        ''' Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book''',
                        style: TextStyle(
                            color: smallTextColor,
                            fontSize: 14,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: AppFontWeight.w_500),
                      ),
                    ],
                  ),
                ),
                const SpaceHeight(),
                isShowing
                    ? Column(
                        children: [
                          Divider(
                              color: context.isDark
                                  ? circleAvatarBlackColor
                                  : const Color(0xFFF4F7FA),
                              endIndent: 10,
                              indent: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SpaceWidth(),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: context.isDark
                                      ? circleAvatarBlackColor
                                      : const Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.check,
                                        color: context.isDark
                                            ? const Color(0xffB5B9BC)
                                            : null),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: context.isDark
                                      ? circleAvatarBlackColor
                                      : const Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.bookmark,
                                        color: context.isDark
                                            ? const Color(0xffB5B9BC)
                                            : null),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: context.isDark
                                      ? circleAvatarBlackColor
                                      : const Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.share,
                                        color: context.isDark
                                            ? const Color(0xffB5B9BC)
                                            : null),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: context.isDark
                                      ? circleAvatarBlackColor
                                      : primaryColor,
                                  child: Center(
                                      child: SvgPicture.asset(AppIcon.play,
                                          color: context.isDark
                                              ? const Color(0xffB5B9BC)
                                              : null)),
                                ),
                              ),
                              const SpaceWidth(),
                            ],
                          ),
                          const SpaceHeight()
                        ],
                      )
                    : const SizedBox.shrink(),
                GestureDetector(
                  onTap: () {
                    isShowing = !isShowing;
                    setState(() {});
                  },
                  child: Container(
                    height: 25.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r)),
                      color: context.isDark
                          ? const Color(0xff232C37)
                          : primaryColor.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Icon(
                          isShowing
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: context.isDark
                              ? const Color(0xff6D7379)
                              : primaryColor),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
