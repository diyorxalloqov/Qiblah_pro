// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

// class SuralarDetailsPage extends StatefulWidget {
//   final SuralarDetailsPageArguments data;
//   const SuralarDetailsPage({super.key, required this.data});

//   @override
//   State<SuralarDetailsPage> createState() => _SuralarDetailsPageState();
// }

// class _SuralarDetailsPageState extends State<SuralarDetailsPage> {
//   final ScrollController _scrollController = ScrollController();
//   int itemCount = 0;
//   bool _isSearch = false;
//   @override
//   void initState() {
//     context.read<QuronBloc>().add(GetOyatFromDB(index: widget.data.index));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _isSearch
//           ? AppBar(
//             scrolledUnderElevation: 0,
//               leading: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: Container(
//                     width: 28,
//                     height: 28,
//                     decoration: ShapeDecoration(
//                       color: Colors.white.withOpacity(0.1),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: SvgPicture.asset(AppIcon.arrowLeft,
//                         color: context.isDark ? const Color(0xffB5B9BC) : null),
//                   )),
//               title: TextFormField(
//                 decoration: InputDecoration(
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       _isSearch = false;
//                       setState(() {});
//                     },
//                     icon: SvgPicture.asset(AppIcon.cancel),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         const BorderSide(color: Color(0xffE3E7EA), width: 1),
//                   ),
//                 ),
//               ),
//             )
//           : customAppbar(
//               context,
//               widget.data.suraName,
//               icon1: AppIcon.filter,
//               icon2: AppIcon.search,
//               onTap1: () => showSettingBottomSheet(context),
//               onTap2: () => setState(() {
//                 _isSearch = true;
//               }),
//             ),
//       body: BlocBuilder<QuronBloc, QuronState>(
//         builder: (context, state) {
//           print(
//               "${state.status1} STATUS SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
//           print(state.status);

//           if (state.status1 == ActionStatus.isLoading) {
//             return const LoadingPage();
//           }
//           if (state.status1 == ActionStatus.isSuccess) {
//             return DraggableScrollbar.semicircle(
//               controller: _scrollController,
//               backgroundColor: context.isDark ? mainBlugreyColor : Colors.white,
//               labelTextBuilder: (offsetY) {
//                 print(offsetY);
//                 itemCount = offsetY ~/ 400;
//                 return Text(itemCount.toString());
//               },
//               child: ListView.builder(
//                   controller: _scrollController,
//                   itemCount: state.oyatModel.length,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   itemBuilder: (context, index) {
//                     return TanlanganlarItem(index: index, state: state);
//                   }),
//             );
//           } else if (state.status1 == ActionStatus.isError) {
//             return Center(
//               child: Text(state.error),
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//       bottomNavigationBar: BlocBuilder<QuronBloc, QuronState>(
//         builder: (context, state) {
//           return BottomAppBar(
//             elevation: 0.5,
//             child: ListTile(
//               leading: Container(
//                 width: 28,
//                 height: 28,
//                 decoration: ShapeDecoration(
//                   color: primaryColor,
//                   shape: const StarBorder(
//                     points: 8,
//                     innerRadiusRatio: 0.84,
//                   ),
//                 ),
//                 child: Center(
//                     child: Text(
//                   '${widget.data.index}',
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 13,
//                       fontWeight: AppFontWeight.w_500),
//                 )),
//               ),
//               title: Text(
//                 widget.data.suraName,
//                 style: TextStyle(
//                   fontSize: AppSizes.size_14,
//                   fontFamily: AppfontFamily.inter.fontFamily,
//                   fontWeight: AppFontWeight.w_600,
//                 ),
//               ),
//               subtitle: Text(
//                 '${state.oyatModel.length} ${('oyat').tr()}',
//                 style: TextStyle(
//                   fontSize: AppSizes.size_12,
//                   fontFamily: AppfontFamily.inter.fontFamily,
//                   fontWeight: AppFontWeight.w_400,
//                 ),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(100.r),
//                     child: CircleAvatar(
//                       backgroundColor: context.isDark
//                           ? Colors.transparent
//                           : circleAvatarColor,
//                       child: const Center(child: Icon(Icons.fast_rewind_sharp)),
//                     ),
//                   ),
//                   const SpaceWidth(),
//                   InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(100.r),
//                     child: CircleAvatar(
//                       backgroundColor: primaryColor,
//                       child: Center(
//                         child: SvgPicture.asset(AppIcon.play),
//                       ),
//                     ),
//                   ),
//                   const SpaceWidth(),
//                   InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(100.r),
//                     child: CircleAvatar(
//                       backgroundColor: context.isDark
//                           ? Colors.transparent
//                           : circleAvatarColor,
//                       child: const Center(
//                         child: Icon(Icons.fast_forward),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class TanlanganlarItem extends StatefulWidget {
//   final int index;
//   final QuronState state;
//   const TanlanganlarItem({super.key, required this.state, required this.index});

//   @override
//   State<TanlanganlarItem> createState() => _TanlanganlarItemState();
// }

// class _TanlanganlarItemState extends State<TanlanganlarItem> {
//   bool isShowing = false;
//   bool isKnown = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SpaceHeight(),
//           Container(
//             decoration: BoxDecoration(
//                 color: context.isDark
//                     ? tanlanganlarItemBlackColor
//                     : tanlanganlarItemColor,
//                 borderRadius: BorderRadius.circular(12.r)),
//             child: Column(
//               children: [
//                 isKnown
//                     ? Container(
//                         height: 5.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(12.r),
//                               topRight: Radius.circular(12.r)),
//                           color: primaryColor,
//                         ),
//                       )
//                     : const SizedBox.shrink(),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const SizedBox.shrink(),
//                           Expanded(
//                             child: Text(
//                               widget.state.oyatModel[widget.index].verseArabic
//                                   .toString(),
//                               overflow: TextOverflow.clip,
//                               textDirection: TextDirection.rtl,
//                               style: TextStyle(
//                                 color: context.isDark
//                                     ? arabicWhiteTextColor
//                                     : arabicTextColor,
//                                 fontSize: widget.state.quronSize ??
//                                     AppSizes.arabicTextSize,
//                                 fontFamily: AppfontFamily.inter.fontFamily,
//                                 fontWeight: AppFontWeight.arabicFontWeight,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         '${widget.state.oyatModel[widget.index].verseNumber} ${widget.state.oyatModel[widget.index].text}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: context.isDark ? Colors.white : Colors.black,
//                           fontStyle: FontStyle.italic,
//                           fontFamily: AppfontFamily.inter.fontFamily,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SpaceHeight(),
//                       Text(
//                         '''${widget.state.oyatModel[widget.index].meaning}''',
//                         style: TextStyle(
//                             color: smallTextColor,
//                             fontSize: widget.state.textSize ?? 14.0,
//                             fontFamily: AppfontFamily.inter.fontFamily,
//                             fontWeight: AppFontWeight.w_500),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SpaceHeight(),
//                 isShowing
//                     ? Column(
//                         children: [
//                           Divider(
//                               color: context.isDark
//                                   ? circleAvatarBlackColor
//                                   : const Color(0xFFF4F7FA),
//                               endIndent: 10,
//                               indent: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               const SpaceWidth(),
//                               InkWell(
//                                 onTap: () {
//                                   isKnown = !isKnown;
//                                   setState(() {});
//                                 },
//                                 borderRadius: BorderRadius.circular(100.r),
//                                 child: CircleAvatar(
//                                   backgroundColor: context.isDark
//                                       ? circleAvatarBlackColor
//                                       : const Color(0xFFF4F7FA),
//                                   child: Center(
//                                     child: SvgPicture.asset(AppIcon.check,
//                                         color: context.isDark
//                                             ? const Color(0xffB5B9BC)
//                                             : null),
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {},
//                                 borderRadius: BorderRadius.circular(100.r),
//                                 child: CircleAvatar(
//                                   backgroundColor: context.isDark
//                                       ? circleAvatarBlackColor
//                                       : const Color(0xFFF4F7FA),
//                                   child: Center(
//                                     child: SvgPicture.asset(AppIcon.bookmark,
//                                         color: context.isDark
//                                             ? const Color(0xffB5B9BC)
//                                             : null),
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {},
//                                 borderRadius: BorderRadius.circular(100.r),
//                                 child: CircleAvatar(
//                                   backgroundColor: context.isDark
//                                       ? circleAvatarBlackColor
//                                       : const Color(0xFFF4F7FA),
//                                   child: Center(
//                                     child: SvgPicture.asset(AppIcon.share,
//                                         color: context.isDark
//                                             ? const Color(0xffB5B9BC)
//                                             : null),
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {},
//                                 borderRadius: BorderRadius.circular(100.r),
//                                 child: CircleAvatar(
//                                   backgroundColor: context.isDark
//                                       ? circleAvatarBlackColor
//                                       : primaryColor,
//                                   child: Center(
//                                       child: SvgPicture.asset(AppIcon.play,
//                                           color: context.isDark
//                                               ? const Color(0xffB5B9BC)
//                                               : null)),
//                                 ),
//                               ),
//                               const SpaceWidth(),
//                             ],
//                           ),
//                           const SpaceHeight()
//                         ],
//                       )
//                     : const SizedBox.shrink(),
//                 GestureDetector(
//                   onTap: () {
//                     isShowing = !isShowing;
//                     setState(() {});
//                   },
//                   child: Container(
//                     height: 25.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(12.r),
//                           bottomRight: Radius.circular(12.r)),
//                       color: context.isDark
//                           ? const Color(0xff232C37)
//                           : primaryColor.withOpacity(0.15),
//                     ),
//                     child: Center(
//                       child: Icon(
//                           isShowing
//                               ? Icons.keyboard_arrow_up_rounded
//                               : Icons.keyboard_arrow_down_rounded,
//                           color: context.isDark
//                               ? const Color(0xff6D7379)
//                               : primaryColor),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class SuralarDetailsPage extends StatefulWidget {
  final SuralarDetailsPageArguments data;
  const SuralarDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<SuralarDetailsPage> createState() => _SuralarDetailsPageState();
}

class _SuralarDetailsPageState extends State<SuralarDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  int itemCount = 0;
  bool _isSearch = false;
  final TextEditingController _searchController = TextEditingController();

  ///// oqilgan bilan save ni tekshirish

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearch
          ? AppBar(
              scrolledUnderElevation: 0,
              leading: IconButton(
                onPressed: () => _isSearch
                    ? setState(() => _isSearch = false)
                    : Navigator.pop(context),
                icon: Container(
                  width: 28,
                  height: 28,
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppIcon.arrowLeft,
                    color: context.isDark ? const Color(0xffB5B9BC) : null,
                  ),
                ),
              ),
              title: TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    icon: SvgPicture.asset(AppIcon.cancel),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xffE3E7EA),
                      width: 1,
                    ),
                  ),
                ),
              ),
            )
          : customAppbar(
              context,
              widget.data.suraName,
              icon1: AppIcon.filter,
              icon2: AppIcon.search,
              onTap1: () => showSettingBottomSheet(context),
              onTap2: () => setState(() {
                _isSearch = true;
              }),
            ),
      body: BlocBuilder<QuronBloc, QuronState>(
        builder: (context, state) {
          if (state.status1 == ActionStatus.isLoading) {
            return const LoadingPage();
          }
          if (state.status1 == ActionStatus.isSuccess) {
            return DraggableScrollbar.semicircle(
              controller: _scrollController,
              backgroundColor: context.isDark ? mainBlugreyColor : Colors.white,
              labelTextBuilder: (offsetY) {
                print(offsetY);
                itemCount = offsetY ~/ 400;
                return Text(itemCount.toString());
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.oyatModel.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                itemBuilder: (context, index) {
                  final item = state.oyatModel[index];
                  final searchText = _searchController.text.toLowerCase();
                  if (searchText.isEmpty ||
                      item.verseArabic!.toLowerCase().contains(searchText) ||
                      item.text!.toLowerCase().contains(searchText) ||
                      item.meaning!.toLowerCase().contains(searchText)) {
                    return TanlanganlarItem(
                        index: index,
                        state: state,
                        controller: _searchController);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            );
          } else if (state.status1 == ActionStatus.isError) {
            return Center(
              child: Text(state.error),
            );
          }
          return SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<QuronBloc, QuronState>(
        builder: (context, state) {
          return BottomAppBar(
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
                      fontWeight: AppFontWeight.w_500,
                    ),
                  ),
                ),
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
                '${widget.data.suraVerseCount} ${('oyat').tr()}',
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
                      child: const Center(
                        child: Icon(Icons.fast_rewind_sharp),
                      ),
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
          );
        },
      ),
    );
  }
}

class TanlanganlarItem extends StatefulWidget {
  final int index;
  final QuronState state;
  final TextEditingController controller;
  const TanlanganlarItem({
    Key? key,
    required this.state,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  State<TanlanganlarItem> createState() => _TanlanganlarItemState();
}

class _TanlanganlarItemState extends State<TanlanganlarItem> {
  bool isShowing = false;
  bool isKnown = false;
  bool isSaved = false;

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
                isKnown
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
                              widget.state.oyatModel[widget.index].verseArabic
                                  .toString(),
                              overflow: TextOverflow.clip,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: !widget.state.oyatModel[widget.index]
                                        .verseArabic!
                                        .toLowerCase()
                                        .contains(widget.controller.text
                                            .toLowerCase())
                                    ? primaryColor
                                    : context.isDark
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
                        '${widget.state.oyatModel[widget.index].verseNumber} ${widget.state.oyatModel[widget.index].text}',
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
                        '''${widget.state.oyatModel[widget.index].meaning}''',
                        style: TextStyle(
                          color: smallTextColor,
                          fontSize: widget.state.textSize ?? 14.0,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: AppFontWeight.w_500,
                        ),
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
                            indent: 10,
                          ),
                          BlocBuilder<QuronBloc, QuronState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SpaceWidth(),
                                  InkWell(
                                    onTap: () {
                                      isKnown = !isKnown;
                                      setState(() {});
                                      context.read<QuronBloc>().add(
                                          IsReadedItemEvent(isReaded: isKnown));
                                    },
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: CircleAvatar(
                                      backgroundColor: context.isDark
                                          ? circleAvatarBlackColor
                                          : const Color(0xFFF4F7FA),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          AppIcon.check,
                                          color: context.isDark
                                              ? const Color(0xffB5B9BC)
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isSaved = !isSaved;
                                      setState(() {});
                                      context.read<QuronBloc>().add(
                                          IsSavedItemEvent(isSaved: isSaved));
                                    },
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: CircleAvatar(
                                      backgroundColor: context.isDark
                                          ? circleAvatarBlackColor
                                          : const Color(0xFFF4F7FA),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          AppIcon.bookmark,
                                          color: isSaved
                                              ? primaryColor
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
                              );
                            },
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
