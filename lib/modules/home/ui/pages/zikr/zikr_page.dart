import 'package:cached_network_image/cached_network_image.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/global/widgets/error_screen.dart';
import 'package:qiblah_pro/modules/home/ui/pages/zikr/saved_zikrs_details.dart';

class ZikrPage extends StatefulWidget {
  const ZikrPage({super.key});

  @override
  State<ZikrPage> createState() => _ZikrPageState();
}

class _ZikrPageState extends State<ZikrPage> {
  // late PageController _pageController;
  // int _currentPage = 0;

  @override
  void initState() {
    // _pageController = PageController(initialPage: 0);
    context.read<ZikrBloc>().add(ZikrCategoryGetDBEvent());
    StorageRepository.getInt(Keys.currentDate) != DateTime.now().day
        ? context.read<ZikrBloc>().add(ChangeZeroTodayZikrs())
        : null;
    super.initState();
  }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  // double percent = 0.53;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context, 'ficha_zikr'.tr()),
        body: BlocBuilder<ZikrBloc, ZikrState>(
          builder: (context, state) {
            if (state.status == ActionStatus.isLoading) {
              return const LoadingPage();
            } else if (state.status == ActionStatus.isSuccess) {
              return Padding(
                padding: EdgeInsets.all(15.dg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Socket uchun
                    //
                    // SizedBox(
                    //   height: 190.h,
                    //   child: Column(
                    //     children: [
                    //       Expanded(
                    //         child: PageView.builder(
                    //           // controller: _pageController,
                    //           // onPageChanged: (value) {
                    //           //   _currentPage = value;
                    //           //   setState(() {});
                    //           // },
                    //           itemBuilder: (context, index) {
                    //             return Container(
                    //               padding: const EdgeInsets.all(15),
                    //               decoration: BoxDecoration(
                    //                 color: context.isDark
                    //                     ? containerBlackColor
                    //                     : containerColor,
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     "Dekabr uchun 1,000,000 savolat chellen...",
                    //                     style: TextStyle(
                    //                         color: context.isDark
                    //                             ? Colors.white
                    //                             : Colors.black,
                    //                         fontWeight: AppFontWeight.w_600,
                    //                         fontSize: AppSizes.size_16),
                    //                   ),
                    //                   const SpaceHeight(),
                    //                   SmallText(text: 'qoldi'.tr()),
                    //                   const Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       MediumText(text: '4 000 000'),
                    //                       Row(
                    //                         children: [
                    //                           Icon(Icons.people,
                    //                               color: Colors.grey),
                    //                           SpaceWidth(),
                    //                           Text('356')
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   const SpaceHeight(),
                    //                   LinearPercentIndicator(
                    //                     animation: true,
                    //                     animationDuration: 1000,
                    //                     backgroundColor: context.isDark
                    //                         ? mainBlugreyColor
                    //                         : const Color(0xffF1F1FA),
                    //                     progressColor: primaryColor,
                    //                     animateFromLastPercent: true,
                    //                     percent: percent,
                    //                     lineHeight: 15,
                    //                     trailing:
                    //                         Text('${(percent * 100).toInt()}%'),
                    //                     barRadius: const Radius.circular(47),
                    //                   )
                    //                 ],
                    //               ),
                    //             );
                    //           },
                    //           itemCount: 5,
                    //         ),
                    //       ),
                    //       const SizedBox(height: 10),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           // i coming backend data length
                    //           for (int i = 0; i < 5; i++)
                    //             AnimatedContainer(
                    //               margin:
                    //                   const EdgeInsets.symmetric(horizontal: 2),
                    //               decoration: BoxDecoration(
                    //                 color: _currentPage == i
                    //                     ? primaryColor
                    //                     : context.isDark
                    //                         ? mainBlugreyColor
                    //                         : Colors.grey.shade400,
                    //                 borderRadius: BorderRadius.circular(100),
                    //               ),
                    //               width: 10,
                    //               height: 10,
                    //               duration: const Duration(milliseconds: 300),
                    //             ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  crossAxisCount: 2),
                          itemCount: state.zikrCategroyModel.isNotEmpty
                              ? state.zikrCategroyModel.length + 2
                              : 2,
                          itemBuilder: (context, index) {
                            if (index == (state.zikrCategroyModel.length)) {
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NamesPage())),
                                child: Container(
                                  height: 170.h,
                                  width: 154.w,
                                  decoration: BoxDecoration(
                                      color: context.isDark
                                          ? containerBlackColor
                                          : asmaul_husna,
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              AppImages.asmaul_husna),
                                          alignment: Alignment.bottomRight),
                                      borderRadius:
                                          BorderRadius.circular(18.r)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "asmo_ul_husna".tr(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontFamily:
                                              AppfontFamily.inter.fontFamily,
                                          fontSize: AppSizes.size_18,
                                          fontWeight: AppFontWeight.w_500),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (index == state.zikrCategroyModel.length + 1) {
                              return GestureDetector(
                                onTap: () {
                                  // StorageRepository.getString(
                                  //             Keys.currentDate) !=
                                  //         DateTime.now().toString()
                                  //     ? context.read<ZikrBloc>().add(
                                  //         SavedZikrCountEvent(
                                  //             zikrId: state.savedZikrs[index]
                                  //                     .zikrId ??
                                  //                 '0',
                                  //             allZikrs: state.savedZikrs[index]
                                  //                     .allZikrs ??
                                  //                 0,
                                  //             todayZikrs: 0))
                                  //     : null;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SavedZikrs()));
                                },
                                child: Container(
                                  height: 170.h,
                                  width: 154.w,
                                  decoration: BoxDecoration(
                                      color: context.isDark
                                          ? containerBlackColor
                                          : tanlangan_zikrlar,
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              AppImages.tanlangan_zkir),
                                          alignment: Alignment.bottomRight),
                                      borderRadius:
                                          BorderRadius.circular(18.r)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "zikr".tr(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontFamily:
                                              AppfontFamily.inter.fontFamily,
                                          fontSize: AppSizes.size_18,
                                          fontWeight: AppFontWeight.w_500),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                context.read<ZikrBloc>().add(ZikrGetFromDBEvent(
                                    categoryId: state.zikrCategroyModel[index]
                                            .categoryId ??
                                        '0'));
                                Navigator.pushNamed(context, 'zikrMain',
                                    arguments: ZikrArguments(
                                        categoryName: state
                                                .zikrCategroyModel[index]
                                                .categoryName ??
                                            '',
                                        categoryId: state
                                                .zikrCategroyModel[index]
                                                .categoryId ??
                                            '0'));
                              },
                              child: Container(
                                height: 170.h,
                                width: 154.w,
                                decoration: BoxDecoration(
                                    color: context.isDark
                                        ? containerBlackColor
                                        : hexToColor(
                                            "#${state.zikrCategroyModel[index].categoryBackgroundColor}"),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(state
                                                .zikrCategroyModel[index]
                                                .categoryImageLink ??
                                            ''),
                                        alignment: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(18.r)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    state.zikrCategroyModel[index]
                                            .categoryName ??
                                        '',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        overflow: TextOverflow.clip,
                                        fontFamily:
                                            AppfontFamily.inter.fontFamily,
                                        fontSize: AppSizes.size_18,
                                        fontWeight: AppFontWeight.w_500),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else if (state.status == ActionStatus.isError) {
              return NoNetworkScreen(
                  onTap: () =>
                      context.read<ZikrBloc>().add(ZikrCategoryGetDBEvent()));
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
