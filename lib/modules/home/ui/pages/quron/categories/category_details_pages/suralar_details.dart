import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SuralarDetailsPage extends StatefulWidget {
  final SuralarDetailsPageArguments data;
  const SuralarDetailsPage({super.key, required this.data});

  @override
  State<SuralarDetailsPage> createState() => _SuralarDetailsPageState();
}

class _SuralarDetailsPageState extends State<SuralarDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  int itemCount = 0;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuronBloc, QuronState>(
      builder: (context, state) {
        if (state.status1 == ActionStatus.isLoading) {
          return const LoadingPage();
        }
        if (state.status1 == ActionStatus.isSuccess) {
          return Scaffold(
            appBar: customAppbar(context, widget.data.suraName,
                icon1: AppIcon.filter,
                icon2: AppIcon.search,
                onTap1: () => showSettingBottomSheet(context),
                onTap2: () {}),
            body: DraggableScrollbar.semicircle(
              controller: _scrollController,
              backgroundColor: context.isDark ? mainBlugreyColor : Colors.white,
              labelTextBuilder: (offsetY) {
                // itemCount = offsetY
                return Text("${'s'}");
              },
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.oyatModel.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  itemBuilder: (context, index) {
                    return TanlanganlarItem(index: index);
                  }),
            ),
            bottomNavigationBar: BottomAppBar(
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
                  '${state.oyatModel.length} ${('oyat').tr()}',
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
                        backgroundColor: context.isDark
                            ? Colors.transparent
                            : circleAvatarColor,
                        child:
                            const Center(child: Icon(Icons.fast_rewind_sharp)),
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
                        backgroundColor: context.isDark
                            ? Colors.transparent
                            : circleAvatarColor,
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
        } else if (state.status1 == ActionStatus.isError) {
          return Center(child: Text(state.error));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class TanlanganlarItem extends StatefulWidget {
  final int index;
  const TanlanganlarItem({super.key, required this.index});

  @override
  State<TanlanganlarItem> createState() => _TanlanganlarItemState();
}

class _TanlanganlarItemState extends State<TanlanganlarItem> {
  bool isShowing = false;
  bool isKnown = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuronBloc, QuronState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceHeight(),
              Container(
                decoration: BoxDecoration(
                    color: context.isDark
                        ? tanlanganlarItemBlackColor
                        : tanlanganlarItemColor,
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
                              Expanded(
                                child: Text(
                                  state.oyatModel[widget.index].verseArabic
                                      .toString(),
                                  overflow: TextOverflow.clip,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: context.isDark
                                        ? arabicWhiteTextColor
                                        : arabicTextColor,
                                    fontSize: state.quronSize ??
                                        AppSizes.arabicTextSize,
                                    fontFamily: AppfontFamily.inter.fontFamily,
                                    fontWeight: AppFontWeight.arabicFontWeight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${state.oyatModel[widget.index].verseNumber} ${state.oyatModel[widget.index].text}',
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  context.isDark ? Colors.white : Colors.black,
                              fontStyle: FontStyle.italic,
                              fontFamily: AppfontFamily.inter.fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SpaceHeight(),
                          Text(
                            '''${state.oyatModel[widget.index].meaning}''',
                            style: TextStyle(
                                color: smallTextColor,
                                fontSize: state.textSize ?? 14.0,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SpaceWidth(),
                                  InkWell(
                                    onTap: () {
                                      isKnown = !isKnown;
                                      setState(() {});
                                    },
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
                                        child: SvgPicture.asset(
                                            AppIcon.bookmark,
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
      },
    );
  }
}
