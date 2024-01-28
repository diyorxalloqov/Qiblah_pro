import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class JuzlarDetailsPage extends StatefulWidget {
  final JuzlarDetailsArgument data;
  const JuzlarDetailsPage({super.key, required this.data});

  @override
  State<JuzlarDetailsPage> createState() => _SuralarDetailsPageState();
}

class _SuralarDetailsPageState extends State<JuzlarDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, widget.data.suraName,
          icon1: AppIcon.filter,
          icon2: AppIcon.search,
          onTap1: () {},
          onTap2: () => showSettingBottomSheet(context)),
      body: DraggableScrollbar.semicircle(
        controller: _scrollController,
        labelTextBuilder: (offsetY) => Text("${offsetY ~/ 100}"),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            itemBuilder: (context, index) {
              return const TanlanganlarItem();
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: bottomAppbarColor,
        elevation: 0.5,
        child: ListTile(
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
              '${widget.data.index}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: AppFontWeight.w_500),
            )),
          ),
          title: Text(
            widget.data.suraName,
            style: TextStyle(
              fontSize: AppSizes.size_14,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_600,
            ),
          ),
          subtitle: Text(
            '135 oyat',
            style: TextStyle(
              fontSize: AppSizes.size_12,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_400,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(100.r),
                child: CircleAvatar(
                  backgroundColor: circleAvatarColor,
                  child: const Center(child: Icon(Icons.fast_rewind_sharp)),
                ),
              ),
              const SpaceWidth(),
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
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(100.r),
                child: CircleAvatar(
                  backgroundColor: circleAvatarColor,
                  child: const Center(
                    child: Icon(Icons.fast_forward),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TanlanganlarItem extends StatefulWidget {
  const TanlanganlarItem({super.key});

  @override
  State<TanlanganlarItem> createState() => _TanlanganlarItemState();
}

class _TanlanganlarItemState extends State<TanlanganlarItem> {
  bool isShowing = false;
  bool isKnown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceHeight(),
          Container(
            decoration: BoxDecoration(
                color: tanlanganlarItemColor,
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              children: [
                isKnown
                    ? Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r)),
                          color: primaryColor,
                        ),
                      )
                    : const SizedBox.shrink(),
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
                                onTap: () {
                                  isKnown = !isKnown;
                                  setState(() {});
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: circleAvatarColor,
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.check),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: circleAvatarColor,
                                  child: Center(
                                    child: SvgPicture.asset(AppIcon.bookmark),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: circleAvatarColor,
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
