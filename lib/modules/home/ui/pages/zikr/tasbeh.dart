import 'package:connectivity_plus/connectivity_plus.dart';
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
  int index = 0;
  String _selectedItem = ZikrBloc.tasbehSizes[0].toString();
  bool isVibration = false;
  final AudioPlayer player = AudioPlayer();
  String error = '';
  String exeption = '';
  bool isDownloading = false;
  late TabController _tabController;

  @override
  void initState() {
    widget.zikrDetailsArgument.zikrBloc.add(ZikrCategoryGetDBEvent());
    print(widget.zikrDetailsArgument.zikrBloc.state.zikrModel.length);
    _tabController = TabController(
        length: widget.zikrDetailsArgument.zikrBloc.state.zikrModel.length,
        vsync: this,
        initialIndex: widget.zikrDetailsArgument.currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
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
      print('Error initializing audio: $e');
      setState(() {
        error = 'Audio yuklashda xatolik';
      });
    }
  }

  Future<void> _downloadAudio(String url, String savePath) async {
    final Dio client = serviceLocator<DioSettings>().dio;
    try {
      final Response response = await client.download(url, savePath);
      print('Downloaded audio: $response');
    } on DioException catch (e) {
      print('Error downloading audio: $e');
      exeption = NetworkExeptionResponse(e).messageForUser;
    }
  }

  Future<String> _getLocalFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/audio_$fileName.mp3';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZikrBloc, ZikrState>(
      bloc: widget.zikrDetailsArgument.zikrBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
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
                onSelected: (value) {
                  _selectedItem = ZikrBloc.tasbehSizes[value].toString();
                  index = value;
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Text(_selectedItem),
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
              IconButton(
                  onPressed: () {
                    widget.zikrDetailsArgument.zikrBloc.add(RefreshZikrEvent());
                    setState(() {});
                  },
                  icon: SvgPicture.asset(AppIcon.refresh,
                      color: context.isDark ? Colors.white : null)),
              IconButton(
                  onPressed: () {
                    isVibration = !isVibration;
                    setState(() {});
                    widget.zikrDetailsArgument.zikrBloc
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
                  //  Color(0xffF5F4FA),
                  borderRadius: BorderRadius.circular(12.r),
                ),
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
                  // 
                  // 
                  // 
                  // 
                  await _init(state.zikrModel[b].zikrAudioLink ?? '',
                      state.zikrModel[b].zikrAudioName ?? '');
                },
                tabs: List.generate(
                  state.zikrModel.length,
                  (index) => Tab(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      state.zikrModel[index].zikrTitle ?? '',
                      style: TextStyle(
                          fontSize: AppSizes.size_14,
                          fontFamily: AppfontFamily.comforta.fontFamily,
                          fontWeight: AppFontWeight.w_700),
                    ),
                  )),
                )),
          ),
          body: Column(
            children: [
              Expanded(
                  // flex: 6,
                  child: TabBarView(
                      controller: _tabController,
                      children: List.generate(
                          state.zikrModel.length,
                          (index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
                                decoration: BoxDecoration(
                                    color: context.isDark
                                        ? containerBlackColor
                                        : containerColor,
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print(state.zikrModel[index].zikrInfo);
                                        showAdaptiveDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) =>
                                                AlertDialog.adaptive(
                                                  scrollable: true,
                                                  // content: HtmlElementView(
                                                  //   viewType: state
                                                  //           .zikrModel[index]
                                                  //           .zikrInfo ??
                                                  //       '',
                                                  // )
                                                ));
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SpaceHeight(),
                                          Text(
                                            state.zikrModel[index].zikrTitle ??
                                                '',
                                            style: TextStyle(
                                                fontFamily: AppfontFamily
                                                    .comforta.fontFamily,
                                                fontSize: AppSizes.size_20,
                                                fontWeight:
                                                    AppFontWeight.w_700),
                                          ),
                                          const SpaceHeight(),
                                          Text(
                                            state.zikrModel[index]
                                                    .zikrDescription ??
                                                '',
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontFamily: AppfontFamily
                                                    .inter.fontFamily,
                                                fontSize: AppSizes.size_16,
                                                color: smallTextColor,
                                                fontWeight:
                                                    AppFontWeight.w_400),
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
                                          InkWell(
                                            onTap: () {},
                                            radius: 16.r,
                                            child: CircleAvatar(
                                              radius: 16.r,
                                              backgroundColor: context.isDark
                                                  ? circleAvatarBlackColor
                                                  : circleAvatarColor,
                                              child: Center(
                                                child: SvgPicture.asset(
                                                    AppIcon.bookmark,
                                                    color: context.isDark
                                                        ? Colors.white
                                                        : null),
                                              ),
                                            ),
                                          ),
                                          SpaceWidth(width: 18.w),
                                          InkWell(
                                            onTap: () {
                                              FlutterShare.share(
                                                  title: 'title');
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
                                              final playerState = snapshot.data;
                                              final processingState =
                                                  playerState?.processingState;
                                              final playing =
                                                  playerState?.playing;
                                              print(
                                                  'Processing State: $processingState');
                                              print('Is Playing: $playing');
                                              if (processingState ==
                                                      ProcessingState.loading ||
                                                  processingState ==
                                                      ProcessingState
                                                          .buffering ||
                                                  isDownloading) {
                                                return CircleAvatar(
                                                  radius: 16.r,
                                                  backgroundColor: primaryColor,
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
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      error)));
                                                      await _init(
                                                          state.zikrModel[index]
                                                                  .zikrAudioLink ??
                                                              '',
                                                          state.zikrModel[index]
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
                                                          print(
                                                              'connectivity result');
                                                          setState(() {
                                                            error = '';
                                                            player.stop();
                                                          });
                                                        }
                                                      });
                                                    } else {
                                                      await _init(
                                                          state.zikrModel[index]
                                                                  .zikrAudioLink ??
                                                              '',
                                                          state.zikrModel[index]
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
                                                  icon: const Icon(Icons.replay,
                                                      color: Colors.white),
                                                  onTap: () {
                                                    if (error.isEmpty) {
                                                      player
                                                          .seek(Duration.zero);
                                                    }
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SpaceHeight()
                                  ],
                                ),
                              )))),
              const SpaceHeight(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          context.isDark ? containerBlackColor : containerColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r))),
                  child: Column(
                    children: [
                      const SpaceHeight(),
                      const SpaceHeight(),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(
                          children: [
                            Text(
                                widget.zikrDetailsArgument.zikrBloc.currentZikr
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
                                  'x${widget.zikrDetailsArgument.zikrBloc.currentZikrOuterCount}',
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
                          print(index);
                          widget.zikrDetailsArgument.zikrBloc
                              .add(IncrementZikr(index: index));
                          setState(() {});
                          if (_isTap) {
                            Future.delayed(const Duration(milliseconds: 160),
                                () {
                              _isTap = false;
                              setState(() {});
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: _isTap ? 95.h : 75.h,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
