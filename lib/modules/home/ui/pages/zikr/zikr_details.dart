import 'dart:async';

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class ZikrMain extends StatefulWidget {
  final ZikrArguments zikrArguments;
  const ZikrMain({super.key, required this.zikrArguments});

  @override
  State<ZikrMain> createState() => _ZikrMainState();
}

class _ZikrMainState extends State<ZikrMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, widget.zikrArguments.categoryName),
      body: BlocBuilder<ZikrBloc, ZikrState>(
        builder: (context, state) {
          if (state.zikrStatus == ActionStatus.isLoading) {
            return const LoadingPage();
          }
          if (state.zikrStatus == ActionStatus.isSuccess) {
            return ListView.builder(
                itemCount: state.zikrModel.length,
                padding: const EdgeInsets.all(12.0),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ZikrItem(
                        index: 1,
                        categoryId: widget.zikrArguments.categoryId,
                        state: state);
                  } else {
                    return ZikrItem(
                        categoryId: widget.zikrArguments.categoryId,
                        index: index + 1,
                        state: state);
                  }
                });
          } else if (state.zikrStatus == ActionStatus.isError) {
            return RefreshIndicator.adaptive(
                onRefresh: () {
                  final completer = Completer<void>();
                  context.read<ZikrBloc>().add(ZikrGetFromDBEvent(
                      categoryId: widget.zikrArguments.categoryId));
                  completer.complete();
                  return completer.future;
                },
                child: ListView(
                  children: [
                    SizedBox(height: context.height * 0.3),
                    Center(child: Text(state.zikrError)),
                  ],
                ));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ZikrItem extends StatefulWidget {
  final int index;
  final ZikrState state;
  final String categoryId;
  const ZikrItem(
      {super.key,
      required this.index,
      required this.categoryId,
      required this.state});

  @override
  State<ZikrItem> createState() => _ZikrItemState();
}

class _ZikrItemState extends State<ZikrItem> {
  bool isSaved = false;

  @override
  void initState() {
    isSaved = widget.state.zikrModel[widget.index - 1].isSaved ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ZikrBloc>().add(RefreshZikrEvent());
        Navigator.pushNamed(context, 'tasbehPage',
            arguments: ZikrDetailsArgument(
                categoryId: widget.categoryId, currentIndex: widget.index - 1));
      },
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
                        'Bugun: ${widget.state.zikrModel[widget.index - 1].todayZikrs} Jami: ${widget.state.zikrModel[widget.index - 1].allZikrs}')
              ],
            ),
            const SpaceHeight(),
            MediumText(
                text: widget.state.zikrModel[widget.index - 1].zikrTitle ?? ''),
            const SpaceHeight(),
            SmallText(
                text:
                    widget.state.zikrModel[widget.index - 1].zikrDescription ??
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
                          zikrId:
                              widget.state.zikrModel[widget.index - 1].zikrId ??
                                  '0',
                          isSaved: isSaved));
                      // context.read<ZikrBloc>().add(
                      //     ZikrGetFromDBEvent(categoryId: widget.categoryId));
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
