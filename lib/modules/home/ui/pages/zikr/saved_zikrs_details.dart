import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SavedZikrs extends StatefulWidget {
  const SavedZikrs({super.key});

  @override
  State<SavedZikrs> createState() => _SavedZikrsState();
}

class _SavedZikrsState extends State<SavedZikrs> {
  @override
  void initState() {
    context.read<ZikrBloc>().add(GetSavedZikrsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'zikr'.tr()),
      body: BlocBuilder<ZikrBloc, ZikrState>(
        builder: (context, state) {
          if (state.savedZikrStatus == ActionStatus.isLoading) {
            return const LoadingPage();
          }
          if (state.savedZikrStatus == ActionStatus.isSuccess) {
            debugPrint("SUCCES");
            return state.savedZikrs.isEmpty
                ? Center(
                    child: Text(
                      'empty_zikrs'.tr(),
                      style: TextStyle(
                          fontFamily: AppfontFamily.comforta.fontFamily,
                          fontWeight: AppFontWeight.w_500,
                          fontSize: AppSizes.size_16),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.savedZikrs.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ZikrItemSaved(index: 1, state: state);
                      } else {
                        return ZikrItemSaved(index: index + 1, state: state);
                      }
                    });
          } else if (state.savedZikrStatus == ActionStatus.isError) {
            return Center(
              child: Text(
                'empty_zikrs'.tr(),
                style: TextStyle(
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontWeight: AppFontWeight.w_500,
                    fontSize: AppSizes.size_16),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ZikrItemSaved extends StatefulWidget {
  final int index;
  final ZikrState state;
  const ZikrItemSaved({super.key, required this.index, required this.state});

  @override
  State<ZikrItemSaved> createState() => _ZikrItemState();
}

class _ZikrItemState extends State<ZikrItemSaved> {
  bool isSaved = false;

  @override
  void initState() {
    isSaved = widget.state.savedZikrs[widget.index - 1].isSaved ?? false;
    super.initState();
  }

  @override
  void deactivate() {
    isSaved = widget.state.savedZikrs[widget.index - 1].isSaved ?? false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'tasbehPage',
          arguments: ZikrDetailsArgument(
              categoryId: '0', currentIndex: widget.index - 1)),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 13.w),
        decoration: BoxDecoration(
            color: context.isDark ? containerBlackColor : containerColor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r))),
                  child: Text(
                    '${widget.index}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SmallText(
                    text:
                        'Bugun: ${widget.state.savedZikrs[widget.index - 1].todayZikrs} Jami: ${widget.state.savedZikrs[widget.index - 1].allZikrs}')
              ],
            ),
            const SpaceHeight(),
            MediumText(
                text:
                    widget.state.savedZikrs[widget.index - 1].zikrTitle ?? ''),
            const SpaceHeight(),
            SmallText(
                text:
                    widget.state.savedZikrs[widget.index - 1].zikrDescription ??
                        ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                IconButton(
                    onPressed: () {
                      isSaved = !isSaved;
                      setState(() {});
                      context.read<ZikrBloc>().add(SavedZikrEvent(
                          zikrId: widget
                                  .state.savedZikrs[widget.index - 1].zikrId ??
                              '0',
                          isSaved: isSaved));
                      context.read<ZikrBloc>().add(GetSavedZikrsEvent());
                    },
                    icon: isSaved
                        ? SvgPicture.asset(AppIcon.bookmark_green)
                        : SvgPicture.asset(
                            AppIcon.bookmark,
                            color: context.isDark ? Colors.white : null,
                          ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
