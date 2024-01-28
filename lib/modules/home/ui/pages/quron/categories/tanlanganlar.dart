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
              color: Colors.black,
              fontSize: AppSizes.size_16,
              fontFamily: AppfontFamily.comforta.fontFamily,
              fontWeight: AppFontWeight.w_700,
            ),
          ),
          const SpaceHeight(),
          Container(
            decoration: BoxDecoration(
                color: tanlanganlarItemColor,
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
                              color: arabicTextColor,
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
                          const Divider(
                              color: Color(0xFFF4F7FA),
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
                                  backgroundColor: Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.check),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.bookmark),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.share),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.play),
                                  ),
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
                      color: primaryColor.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Icon(
                          isShowing
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: primaryColor),
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
