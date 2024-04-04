import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/oyat_model.dart';

class TanlanganlarPage extends StatefulWidget {
  const TanlanganlarPage({super.key});

  @override
  State<TanlanganlarPage> createState() => _TanlanganlarPageState();
}

class _TanlanganlarPageState extends State<TanlanganlarPage> {
  @override
  void initState() {
    context.read<QuronBloc>().add(const GetSavedOyats());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuronBloc, QuronState>(
      builder: (context, state) {
        if (state.savedOyatStatus == ActionStatus.isLoading) {
          return const LoadingPage();
        } else if (state.savedOyatStatus == ActionStatus.isSuccess) {
          if (state.getSavedOyats.isEmpty) {
            return Center(
              child: Text(
                'emptyOyat'.tr(),
                style: TextStyle(
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontWeight: AppFontWeight.w_500,
                    fontSize: AppSizes.size_16),
              ),
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              itemCount: state.getSavedOyats.length,
              itemBuilder: (context, index) {
                List<OyatModel> oyats = state.getSavedOyats;
                return TanlanganlarItem(
                    state: state,
                    index: index,
                    suraId: state.getSavedOyats[index].suraId ?? 0,
                    savedOyats: oyats);
              });
        } else if (state.savedOyatStatus == ActionStatus.isError) {
          return Center(
            child: Text(
              state.savedOyatError,
              style: TextStyle(
                  fontFamily: AppfontFamily.comforta.fontFamily,
                  fontWeight: AppFontWeight.w_500,
                  fontSize: AppSizes.size_16),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class TanlanganlarItem extends StatefulWidget {
  final List<OyatModel> savedOyats;
  final int index;
  final int suraId;
  final QuronState state;
  const TanlanganlarItem(
      {Key? key,
      required this.index,
      required this.state,
      required this.suraId,
      required this.savedOyats})
      : super(key: key);

  @override
  State<TanlanganlarItem> createState() => _TanlanganlarItemState();
}

class _TanlanganlarItemState extends State<TanlanganlarItem> {
  bool isShowing = false;
  bool isReaded = false;
  bool isSaved = false;

  @override
  void initState() {
    print(widget.index);
    //// verse_id boyicha readed saved
    super.initState();
    if (widget.index >= 0 && widget.index < widget.savedOyats.length) {
      isReaded = widget.savedOyats[widget.index].isReaded;
      isSaved = widget.savedOyats[widget.index].isSaved;
    } else {
      isReaded = false;
      isSaved = false;
    }
    print("$isSaved SALOM");
    print("$isReaded ssaaaaaaaaaaalllllloooommmm");
    print("${widget.index} index item coming");
  }

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
              color: context.isDark
                  ? tanlanganlarItemBlackColor
                  : tanlanganlarItemColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                isReaded
                    ? Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                          color: primaryColor,
                        ),
                      )
                    : SizedBox(height: 5.h),
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
                              widget.savedOyats[widget.index].verseArabic
                                  .toString(),
                              overflow: TextOverflow.clip,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: context.isDark
                                    ? arabicWhiteTextColor
                                    : arabicTextColor,
                                fontSize: widget.state.quronSize ??
                                    AppSizes.arabicTextSize,
                                fontFamily: AppfontFamily.inter.fontFamily,
                                fontWeight: AppFontWeight.arabicFontWeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${widget.savedOyats[widget.index].verseNumber} ${widget.savedOyats[widget.index].text}',
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
                        '''${widget.savedOyats[widget.index].meaning}''',
                        style: TextStyle(
                            color: smallTextColor,
                            fontSize: widget.state.textSize ?? 14.0,
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
                                onTap: () async {
                                  // Toggle the isReaded property
                                  isReaded = !isReaded;
                                  setState(() {});
                                  // Trigger the event to update the database
                                  context.read<QuronBloc>().add(ReadedItemEvent(
                                      isReaded: isReaded,
                                      verseNumber: int.parse(widget
                                              .savedOyats[widget.index]
                                              .verseId ??
                                          '0')));

                                  print(isReaded);
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: isReaded
                                      ? primaryColor
                                      : context.isDark
                                          ? circleAvatarBlackColor
                                          : const Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcon.check,
                                      color: isReaded
                                          ? Colors.white
                                          : context.isDark
                                              ? const Color(0xffB5B9BC)
                                              : null,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  isSaved = !isSaved;
                                  setState(() {});
                                  context.read<QuronBloc>().add(SavedItemEvent(
                                      isSaved: isSaved,
                                      verseNumber: int.parse(widget
                                              .savedOyats[widget.index]
                                              .verseId ??
                                          '0')));
                                  !isSaved
                                      ? widget.savedOyats.removeAt(widget.index)
                                      : null;
                                  context
                                      .read<QuronBloc>()
                                      .add(const GetSavedOyats());
                                  isShowing = false;
                                  setState(() {});
                                  print(isSaved);
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  backgroundColor: isSaved
                                      ? primaryColor
                                      : context.isDark
                                          ? circleAvatarBlackColor
                                          : const Color(0xFFF4F7FA),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcon.bookmark,
                                      color: isSaved
                                          ? Colors.white
                                          : context.isDark
                                              ? const Color(0xffB5B9BC)
                                              : null,
                                    ),
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
                                      AppIcon.share,
                                      color: context.isDark
                                          ? const Color(0xffB5B9BC)
                                          : null,
                                    ),
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
                                    child: SvgPicture.asset(
                                      AppIcon.play,
                                      color: context.isDark
                                          ? const Color(0xffB5B9BC)
                                          : null,
                                    ),
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
                        bottomRight: Radius.circular(12.r),
                      ),
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
                            : primaryColor,
                      ),
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
