import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TasbehPage extends StatefulWidget {
  final ZikrDetailsArgument zikrDetailsArgument;
  const TasbehPage({super.key, required this.zikrDetailsArgument});

  @override
  State<TasbehPage> createState() => _TasbehNamePageState();
}

class _TasbehNamePageState extends State<TasbehPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool _isTap = false;
  int index1 = 0;
  String _selectedItem = ZikrBloc.tasbehSizes[0].toString();
  bool isVibration = false;
  final AudioPlayer player = AudioPlayer();
  String error = '';
  String exeption = '';
  bool isDownloading = false;
  late TabController _tabController;
  bool isSaved = false;

  @override
  void initState() {
    ZikrBloc data = context.read<ZikrBloc>();
    _tabController = TabController(
        length: widget.zikrDetailsArgument.categoryId == '0'
            ? data.state.savedZikrs.length
            : data.state.zikrModel.length,
        vsync: this,
        initialIndex: widget.zikrDetailsArgument.currentIndex);
    _tabController.addListener(_handleTabChange);
    isSaved = widget.zikrDetailsArgument.categoryId == '0'
        ? context
                .read<ZikrBloc>()
                .state
                .savedZikrs[widget.zikrDetailsArgument.currentIndex]
                .isSaved ??
            false
        : context
                .read<ZikrBloc>()
                .state
                .zikrModel[widget.zikrDetailsArgument.currentIndex]
                .isSaved ??
            false;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    player.dispose();
    StorageRepository.putInt(Keys.currentDate, DateTime.now().day);
    super.dispose();
  }

  void _handleTabChange() async {
    context.read<ZikrBloc>().add(
        ZikrGetFromDBEvent(categoryId: widget.zikrDetailsArgument.categoryId));
    context.read<ZikrBloc>().add(RefreshZikrEvent());
    if (player.playing) {
      await player.stop();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  Future<void> _init(String url, String fileName) async {
    final String localFilePath = await _getLocalFilePath(fileName);
    final bool fileExists = await File(localFilePath).exists();

    try {
      if (!fileExists) {
        setState(() {
          isDownloading = true;
        });
        await _downloadAudio(url, localFilePath);
        setState(() {
          isDownloading = false;
        });
      }
      // Set the audio source to the local file path
      await player.setFilePath(localFilePath);
    } catch (e) {
      debugPrint('Error initializing audio: $e');
      setState(() {
        error = 'Audio yuklashda xatolik';
      });
    }
  }

  Future<void> _downloadAudio(String url, String savePath) async {
    final Dio client = serviceLocator<DioSettings>().dio;
    try {
      final Response response = await client.download(url, savePath);
      debugPrint('Downloaded audio: $response');
    } on DioException catch (e) {
      debugPrint('Error downloading audio: $e');
      exeption = NetworkExeptionResponse(e).messageForUser;
    }
  }

  Future<String> _getLocalFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/audio_$fileName.mp3';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        didPop
            ? context.read<ZikrBloc>().add(ZikrGetFromDBEvent(
                categoryId: widget.zikrDetailsArgument.categoryId))
            : null;
      },
      child: BlocBuilder<ZikrBloc, ZikrState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              leading: IconButton(
                  onPressed: () {
                    context.read<ZikrBloc>().add(ZikrGetFromDBEvent(
                        categoryId: widget.zikrDetailsArgument.categoryId));
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 28,
                    height: 28,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: SvgPicture.asset(AppIcon.arrowLeft,
                        color: context.isDark ? Colors.white : null),
                  )),
              centerTitle: true,
              title: Text(
                'ficha_zikr'.tr(),
                style: TextStyle(
                    fontFamily: AppfontFamily.comforta.fontFamily,
                    fontWeight: AppFontWeight.w_700,
                    fontSize: AppSizes.size_18),
              ),
              actions: [
                PopupMenuButton(
                  constraints: BoxConstraints(maxWidth: 100.w, minWidth: 80.w),
                  color: context.isDark ? containerBlackColor : Colors.white,
                  onSelected: (value) {
                    _selectedItem = ZikrBloc.tasbehSizes[value].toString();
                    index1 = value;
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                                context.isDark ? Colors.white : zikrItemColor,
                            width: 2)),
                    child: Text(
                      _selectedItem,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.isDark ? Colors.white : Colors.black,
                        fontSize: AppSizes.size_14,
                        fontFamily: AppfontFamily.comforta.fontFamily,
                      ),
                    ),
                  ),
                  itemBuilder: (context) {
                    return ZikrBloc.tasbehSizes.map((size) {
                      return PopupMenuItem(
                        value: ZikrBloc.tasbehSizes.indexOf(size),
                        child: Text(
                          size.toString(),
                          style: TextStyle(
                              color:
                                  context.isDark ? Colors.white : Colors.black),
                        ),
                      );
                    }).toList();
                  },
                ),
                SizedBox(width: 5.w),
                IconButton(
                    onPressed: () {
                      context.read<ZikrBloc>().add(RefreshZikrEvent());
                      setState(() {});
                    },
                    icon: SvgPicture.asset(AppIcon.refresh,
                        color: context.isDark
                            ? Colors.white
                            : containerBlackColor)),
                IconButton(
                    onPressed: () {
                      isVibration = !isVibration;
                      setState(() {});
                      context
                          .read<ZikrBloc>()
                          .add(ZikrVibrationEvent(isVibration: isVibration));
                    },
                    icon: SvgPicture.asset(AppIcon.vibration,
                        color: context.isDark ? Colors.white : null)),
              ],
              bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  splashBorderRadius: BorderRadius.circular(12.r),
                  splashFactory: NoSplash.splashFactory,
                  indicator: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12.r)),
                  labelStyle: TextStyle(
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontWeight: AppFontWeight.w_700,
                      fontSize: AppSizes.size_14),
                  unselectedLabelStyle: TextStyle(
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontWeight: AppFontWeight.w_700,
                      fontSize: AppSizes.size_14),
                  controller: _tabController,
                  labelPadding: EdgeInsets.only(bottom: 5.h, left: 8.w),
                  indicatorPadding: EdgeInsets.only(bottom: 10.h),
                  labelColor: Colors.white,
                  dividerHeight: 0,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor:
                      context.isDark ? Colors.white : Colors.black,
                  onTap: (b) async {
                    context.read<ZikrBloc>().add(RefreshZikrEvent());
                    if (player.playing) {
                      await player.stop();
                    }
                    setState(() {});
                  },
                  tabs: List.generate(
                    widget.zikrDetailsArgument.categoryId == '0'
                        ? state.savedZikrs.length
                        : state.zikrModel.length,
                    (index) => Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          widget.zikrDetailsArgument.categoryId == '0'
                              ? state.savedZikrs[index].zikrTitle ?? ''
                              : state.zikrModel[index].zikrTitle ?? '',
                          style: TextStyle(
                              fontSize: AppSizes.size_14,
                              fontFamily: AppfontFamily.comforta.fontFamily,
                              fontWeight: AppFontWeight.w_700),
                        ),
                      ),
                    ),
                  )),
            ),
            body: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: TabBarView(
                        controller: _tabController,
                        children: List.generate(
                            widget.zikrDetailsArgument.categoryId == '0'
                                ? state.savedZikrs.length
                                : state.zikrModel.length,
                            (index) => Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, top: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: context.isDark
                                          ? containerBlackColor
                                          : containerColor,
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showAdaptiveDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (context) =>
                                                  AlertDialog.adaptive(
                                                      backgroundColor: context
                                                              .isDark
                                                          ? containerBlackColor
                                                          : Colors.white,
                                                      scrollable: true,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r)),
                                                      content: HtmlWidget(
                                                        textStyle: TextStyle(
                                                            color: context
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                        widget.zikrDetailsArgument
                                                                    .categoryId ==
                                                                '0'
                                                            ? state
                                                                    .savedZikrs[
                                                                        index]
                                                                    .zikrInfo ??
                                                                ''
                                                            : state
                                                                    .zikrModel[
                                                                        index]
                                                                    .zikrInfo ??
                                                                '',
                                                      )));
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SpaceHeight(),
                                            Text(
                                              widget.zikrDetailsArgument
                                                          .categoryId ==
                                                      '0'
                                                  ? state.savedZikrs[index]
                                                          .zikrTitle ??
                                                      ''
                                                  : state.zikrModel[index]
                                                          .zikrTitle ??
                                                      '',
                                              style: TextStyle(
                                                  fontFamily: AppfontFamily
                                                      .comforta.fontFamily,
                                                  fontSize: AppSizes.size_20,
                                                  fontWeight:
                                                      AppFontWeight.w_700),
                                            ),
                                            const SpaceHeight(),
                                            Flexible(
                                              child: Text(
                                                widget.zikrDetailsArgument
                                                            .categoryId ==
                                                        '0'
                                                    ? state.savedZikrs[index]
                                                            .zikrDescription ??
                                                        ''
                                                    : state.zikrModel[index]
                                                            .zikrDescription ??
                                                        '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 8,
                                                style: TextStyle(
                                                    fontFamily: AppfontFamily
                                                        .inter.fontFamily,
                                                    fontSize: AppSizes.size_16,
                                                    color: smallTextColor,
                                                    fontWeight:
                                                        AppFontWeight.w_400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BlocListener<ZikrBloc, ZikrState>(
                                              listener: (context, state) {
                                                isSaved = widget
                                                            .zikrDetailsArgument
                                                            .categoryId ==
                                                        '0'
                                                    ? state.savedZikrs[index]
                                                            .isSaved ??
                                                        false
                                                    : state.zikrModel[index]
                                                            .isSaved ??
                                                        false;
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  isSaved = !isSaved;
                                                  setState(() {});
                                                  context.read<ZikrBloc>().add(
                                                      SavedZikrEvent(
                                                          zikrId: state
                                                                  .zikrModel[
                                                                      index]
                                                                  .zikrId ??
                                                              '0',
                                                          isSaved: isSaved));
                                                  context.read<ZikrBloc>().add(
                                                      ZikrGetFromDBEvent(
                                                          categoryId: widget
                                                              .zikrDetailsArgument
                                                              .categoryId));
                                                },
                                                radius: 16.r,
                                                child: CircleAvatar(
                                                  radius: 16.r,
                                                  backgroundColor: context
                                                          .isDark
                                                      ? circleAvatarBlackColor
                                                      : circleAvatarColor,
                                                  child: Center(
                                                    child: isSaved
                                                        ? SvgPicture.asset(
                                                            AppIcon
                                                                .bookmark_green)
                                                        : SvgPicture.asset(
                                                            AppIcon.bookmark,
                                                            color: context
                                                                    .isDark
                                                                ? Colors.white
                                                                : null),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SpaceWidth(width: 18.w),
                                            InkWell(
                                              onTap: () {
                                                FlutterShare.share(
                                                    // text: state.zikrModel[index]
                                                    //         .zikrInfo ??
                                                    //     '',
                                                    title: 'Ilovani ulashish');
                                              },
                                              radius: 16.r,
                                              child: CircleAvatar(
                                                radius: 16.r,
                                                backgroundColor: context.isDark
                                                    ? circleAvatarBlackColor
                                                    : circleAvatarColor,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      AppIcon.share,
                                                      color: context.isDark
                                                          ? Colors.white
                                                          : null),
                                                ),
                                              ),
                                            ),
                                            SpaceWidth(width: 18.w),
                                            StreamBuilder(
                                              stream: player.playerStateStream,
                                              builder: (context, snapshot) {
                                                final playerState =
                                                    snapshot.data;
                                                final processingState =
                                                    playerState
                                                        ?.processingState;
                                                final playing =
                                                    playerState?.playing;
                                                debugPrint(
                                                    'Processing State: ');
                                                debugPrint('Is Playing: ');
                                                if (processingState ==
                                                        ProcessingState
                                                            .loading ||
                                                    processingState ==
                                                        ProcessingState
                                                            .buffering ||
                                                    isDownloading) {
                                                  return CircleAvatar(
                                                    radius: 16.r,
                                                    backgroundColor:
                                                        primaryColor,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  );
                                                } else if (playing != true ||
                                                    error.isNotEmpty) {
                                                  return PlayerIcon(
                                                    backColor: primaryColor,
                                                    icon: SvgPicture.asset(
                                                        AppIcon.play),
                                                    onTap: () async {
                                                      if (error.isNotEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    error)));
                                                        await _init(
                                                            widget.zikrDetailsArgument
                                                                        .categoryId ==
                                                                    '0'
                                                                ? state
                                                                        .savedZikrs[
                                                                            index]
                                                                        .zikrAudioLink ??
                                                                    ''
                                                                : state
                                                                        .zikrModel[
                                                                            index]
                                                                        .zikrAudioLink ??
                                                                    '',
                                                            widget.zikrDetailsArgument
                                                                        .categoryId ==
                                                                    '0'
                                                                ? state
                                                                        .savedZikrs[
                                                                            index]
                                                                        .zikrAudioName ??
                                                                    ''
                                                                : state
                                                                        .zikrModel[
                                                                            index]
                                                                        .zikrAudioName ??
                                                                    '');
                                                        Connectivity()
                                                            .onConnectivityChanged
                                                            .listen(
                                                                (ConnectivityResult
                                                                    result) {
                                                          if (result !=
                                                              ConnectivityResult
                                                                  .none) {
                                                            debugPrint(
                                                                'connectivity result');
                                                            setState(() {
                                                              error = '';
                                                              player.stop();
                                                            });
                                                          }
                                                        });
                                                      } else {
                                                        await _init(
                                                            widget.zikrDetailsArgument
                                                                        .categoryId ==
                                                                    '0'
                                                                ? state
                                                                        .savedZikrs[
                                                                            index]
                                                                        .zikrAudioLink ??
                                                                    ''
                                                                : state
                                                                        .zikrModel[
                                                                            index]
                                                                        .zikrAudioLink ??
                                                                    '',
                                                            widget.zikrDetailsArgument
                                                                        .categoryId ==
                                                                    '0'
                                                                ? state
                                                                        .savedZikrs[
                                                                            index]
                                                                        .zikrAudioName ??
                                                                    ''
                                                                : state
                                                                        .zikrModel[
                                                                            index]
                                                                        .zikrAudioName ??
                                                                    '');
                                                        await player.play();
                                                      }
                                                    },
                                                  );
                                                } else if (processingState ==
                                                        ProcessingState.ready ||
                                                    processingState !=
                                                        ProcessingState
                                                            .completed) {
                                                  return PlayerIcon(
                                                    backColor: primaryColor
                                                        .withOpacity(0.2),
                                                    icon: SvgPicture.asset(
                                                        AppIcon.pause),
                                                    onTap: () async {
                                                      player.pause();
                                                      if (error.isNotEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content:
                                                                  Text(error)),
                                                        );
                                                      }
                                                    },
                                                  );
                                                } else {
                                                  return PlayerIcon(
                                                    backColor: primaryColor,
                                                    icon: const Icon(
                                                        Icons.replay,
                                                        color: Colors.white),
                                                    onTap: () {
                                                      if (error.isEmpty) {
                                                        player.seek(
                                                            Duration.zero);
                                                      }
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SpaceHeight(),
                                    ],
                                  ),
                                )))),
                const SpaceHeight(),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        color: context.isDark
                            ? containerBlackColor
                            : containerColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r))),
                    child: Column(
                      children: [
                        const SpaceHeight(),
                        const SpaceHeight(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 30.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: context.isDark
                                      ? const Color(0xff6D7379)
                                      : const Color(0xffF5F4FA),
                                  width: 5)),
                          child: Column(
                            children: [
                              Text(
                                  context
                                      .read<ZikrBloc>()
                                      .currentZikr
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: AppFontWeight.w_700,
                                      fontFamily:
                                          AppfontFamily.comforta.fontFamily)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "/$_selectedItem",
                                    style: TextStyle(
                                        fontSize: AppSizes.size_18,
                                        fontWeight: AppFontWeight.w_700,
                                        fontFamily:
                                            AppfontFamily.comforta.fontFamily),
                                  ),
                                  const SmallText(text: ' | '),
                                  Text(
                                    'x${context.read<ZikrBloc>().currentZikrOuterCount}',
                                    style: TextStyle(
                                        fontSize: AppSizes.size_18,
                                        fontWeight: AppFontWeight.w_700,
                                        fontFamily:
                                            AppfontFamily.comforta.fontFamily),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _isTap = !_isTap;
                            context
                                .read<ZikrBloc>()
                                .add(IncrementZikr(index: index1));
                            setState(() {});
                            if (_isTap) {
                              Future.delayed(const Duration(milliseconds: 160),
                                  () {
                                _isTap = false;
                                setState(() {});
                              });
                            }
                            int pageindex = _tabController.index;
                            context.read<ZikrBloc>().add(SavedZikrCountEvent(
                                  zikrId: widget
                                              .zikrDetailsArgument.categoryId ==
                                          '0'
                                      ? state.savedZikrs[pageindex].zikrId ??
                                          '0'
                                      : state.zikrModel[pageindex].zikrId ??
                                          '0',
                                  allZikrs:
                                      (widget.zikrDetailsArgument.categoryId ==
                                                  '0'
                                              ? state.savedZikrs[pageindex]
                                                      .allZikrs ??
                                                  0
                                              : state.zikrModel[pageindex]
                                                      .allZikrs ??
                                                  0) +
                                          state.currentZikr +
                                          1,
                                  todayZikrs:
                                      (widget.zikrDetailsArgument.categoryId ==
                                                  '0'
                                              ? state.savedZikrs[pageindex]
                                                      .todayZikrs ??
                                                  0
                                              : state.zikrModel[pageindex]
                                                      .todayZikrs ??
                                                  0) +
                                          state.currentZikr +
                                          1,
                                ));
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            height: _isTap ? 85.h : 75.h,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor,
                                  primaryColor.withOpacity(0.8),
                                  primaryColor
                                ],
                              ),
                              boxShadow: _isTap
                                  ? [
                                      BoxShadow(
                                          color: primaryColor,
                                          blurRadius: 20,
                                          spreadRadius: -5)
                                    ]
                                  : [],
                            ),
                          ),
                        ),
                        SizedBox(height: context.bottom / 9 + 30)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
