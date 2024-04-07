import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class JuzlarDetailsPage extends StatefulWidget {
  final JuzlarDetailsArgument data;
  const JuzlarDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<JuzlarDetailsPage> createState() => _SuralarDetailsPageState();
}

class _SuralarDetailsPageState extends State<JuzlarDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  int itemCount = 0;
  bool _isSearch = false;
  final TextEditingController _searchController = TextEditingController();

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
              title: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                // textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  hintText: 'qidirish'.tr(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    icon: SvgPicture.asset(AppIcon.cancel),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xffE3E7EA),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
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
          if (state.juzStatus == ActionStatus.isLoading) {
            return const LoadingPage();
          }
          if (state.juzStatus == ActionStatus.isSuccess) {
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
                itemCount: state.oyatModelByJuz.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                itemBuilder: (context, index) {
                  final item = state.oyatModelByJuz[index];
                  final searchText = _searchController.text.toLowerCase();
                  if (searchText.isEmpty ||
                      item.verseArabic!.toLowerCase().contains(searchText) ||
                      item.text!.toLowerCase().contains(searchText) ||
                      item.meaning!.toLowerCase().contains(searchText)) {
                    return JuzlarDetailsItem(
                        index: index,
                        state: state,
                        controller: _searchController);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            );
          } else if (state.juzStatus == ActionStatus.isError) {
            return Center(
              child: Text(state.error1),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0.5,
      //   child: ListTile(
      //     leading: Container(
      //       width: 28,
      //       height: 28,
      //       decoration: ShapeDecoration(
      //         color: primaryColor,
      //         shape: const StarBorder(
      //           points: 8,
      //           innerRadiusRatio: 0.84,
      //         ),
      //       ),
      //       child: Center(
      //         child: Text(
      //           '${widget.data.suraId}',
      //           style: const TextStyle(
      //             color: Colors.white,
      //             fontSize: 13,
      //             fontWeight: AppFontWeight.w_500,
      //           ),
      //         ),
      //       ),
      //     ),
      //     title: Text(
      //       widget.data.suraName,
      //       style: TextStyle(
      //         fontSize: AppSizes.size_14,
      //         fontFamily: AppfontFamily.inter.fontFamily,
      //         fontWeight: AppFontWeight.w_600,
      //       ),
      //     ),
      //     subtitle: Text(
      //       '${widget.data.suraVerseCount} ${('oyat').tr()}',
      //       style: TextStyle(
      //         fontSize: AppSizes.size_12,
      //         fontFamily: AppfontFamily.inter.fontFamily,
      //         fontWeight: AppFontWeight.w_400,
      //       ),
      //     ),
      //     trailing: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         InkWell(
      //           onTap: () {},
      //           borderRadius: BorderRadius.circular(100.r),
      //           child: CircleAvatar(
      //             backgroundColor:
      //                 context.isDark ? Colors.transparent : circleAvatarColor,
      //             child: const Center(
      //               child: Icon(Icons.fast_rewind_sharp),
      //             ),
      //           ),
      //         ),
      //         const SpaceWidth(),
      //         InkWell(
      //           onTap: () {},
      //           borderRadius: BorderRadius.circular(100.r),
      //           child: CircleAvatar(
      //             backgroundColor: primaryColor,
      //             child: Center(
      //               child: SvgPicture.asset(AppIcon.play),
      //             ),
      //           ),
      //         ),
      //         const SpaceWidth(),
      //         InkWell(
      //           onTap: () {},
      //           borderRadius: BorderRadius.circular(100.r),
      //           child: CircleAvatar(
      //             backgroundColor:
      //                 context.isDark ? Colors.transparent : circleAvatarColor,
      //             child: const Center(
      //               child: Icon(Icons.fast_forward),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}

class JuzlarDetailsItem extends StatefulWidget {
  final int index;
  final QuronState state;
  final TextEditingController controller;
  const JuzlarDetailsItem(
      {Key? key,
      required this.state,
      required this.controller,
      required this.index})
      : super(key: key);

  @override
  State<JuzlarDetailsItem> createState() => _TanlanganlarItemState();
}

class _TanlanganlarItemState extends State<JuzlarDetailsItem>
    with WidgetsBindingObserver {
  bool isShowing = false;
  bool isReaded = false;
  bool isSaved = false;

  @override
  void initState() {
    print(widget.index);
    //// verse_id boyicha readed saved
    super.initState();
    if (widget.index >= 0 &&
        widget.index < widget.state.oyatModelByJuz.length &&
        widget.state != null) {
      isReaded = widget.state.oyatModelByJuz[widget.index].isReaded;
      isSaved = widget.state.oyatModelByJuz[widget.index].isSaved;
    } else {
      isReaded = false;
      isSaved = false;
    }
  }

  final AudioPlayer player = AudioPlayer();
  String error = '';
  String exeption = '';
  bool isDownloading = false;

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

  Future<void> _init() async {
    String suraNum =
        "${widget.state.oyatModelByJuz[widget.index].suraId}".padLeft(3, '0');
    String juzNumber =
        "${widget.state.oyatModelByJuz[widget.index].verseNumber}"
            .padLeft(3, '0');
    print("$suraNum SURA NUMBER");
    print("$juzNumber Juz oyat NUMBER");
    print(widget.index);

    final String url =
        'https://everyayah.com/data/Alafasy_64kbps/$suraNum$juzNumber.mp3';
    final String localFilePath = await _getLocalFilePath();
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

  Future<String> _getLocalFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/audio_${widget.state.oyatModelByJuz[widget.index].verseId}.mp3';
  }

  /// path tanlash

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
                          widget.state.isShowingArabic
                              ? Expanded(
                                  child: Text(
                                    widget.state.oyatModelByJuz[widget.index]
                                        .verseArabic
                                        .toString(),
                                    overflow: TextOverflow.clip,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: context.isDark
                                          ? arabicWhiteTextColor
                                          : arabicTextColor,
                                      fontSize: widget.state.quronSize ??
                                          AppSizes.arabicTextSize,
                                      fontFamily:
                                          AppfontFamily.inter.fontFamily,
                                      fontWeight:
                                          AppFontWeight.arabicFontWeight,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      widget.state.isShowingReading
                          ? Text(
                              '${widget.state.oyatModelByJuz[widget.index].verseNumber} ${widget.state.oyatModelByJuz[widget.index].text}',
                              style: TextStyle(
                                fontSize: 16,
                                color: context.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontStyle: FontStyle.italic,
                                fontFamily: AppfontFamily.inter.fontFamily,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SpaceHeight(),
                      widget.state.isShowingMeaning
                          ? Text(
                              '''${widget.state.oyatModelByJuz[widget.index].meaning}''',
                              style: TextStyle(
                                  color: smallTextColor,
                                  fontSize: widget.state.textSize ?? 14.0,
                                  fontFamily: AppfontFamily.inter.fontFamily,
                                  fontWeight: AppFontWeight.w_500),
                            )
                          : const SizedBox.shrink(),
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
                                              .state
                                              .oyatModelByJuz[widget.index]
                                              .verseId ??
                                          '0')));

                                  print(isReaded);
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  radius: 16.r,
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
                                              .state
                                              .oyatModelByJuz[widget.index]
                                              .verseId ??
                                          '0')));

                                  print(isSaved);
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: CircleAvatar(
                                  radius: 16.r,
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
                                  radius: 16.r,
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
                              StreamBuilder(
                                stream: player.playerStateStream,
                                builder: (context, snapshot) {
                                  final playerState = snapshot.data;
                                  final processingState =
                                      playerState?.processingState;
                                  final playing = playerState?.playing;
                                  print('Processing State: $processingState');
                                  print('Is Playing: $playing');
                                  if (processingState ==
                                          ProcessingState.loading ||
                                      processingState ==
                                          ProcessingState.buffering ||
                                      isDownloading) {
                                    return CircleAvatar(
                                      radius: 16.r,
                                      backgroundColor: primaryColor,
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                    );
                                  } else if (playing != true ||
                                      error.isNotEmpty) {
                                    return PlayerIcon(
                                      backColor: primaryColor,
                                      icon: SvgPicture.asset(AppIcon.play),
                                      onTap: () async {
                                        if (error.isNotEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(error)));
                                          await _init();
                                          Connectivity()
                                              .onConnectivityChanged
                                              .listen(
                                                  (ConnectivityResult result) {
                                            if (result !=
                                                ConnectivityResult.none) {
                                              print('connectivity result');
                                              setState(() {
                                                error = '';
                                                player.stop();
                                              });
                                            }
                                          });
                                        } else {
                                          await _init();
                                          await player.play();
                                        }
                                      },
                                    );
                                  } else if (processingState ==
                                          ProcessingState.ready ||
                                      processingState !=
                                          ProcessingState.completed) {
                                    return PlayerIcon(
                                      backColor: primaryColor.withOpacity(0.2),
                                      icon: SvgPicture.asset(AppIcon.pause),
                                      onTap: () async {
                                        player.pause();
                                        if (error.isNotEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text(error)),
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
                                          player.seek(Duration.zero);
                                        }
                                      },
                                    );
                                  }
                                },
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
