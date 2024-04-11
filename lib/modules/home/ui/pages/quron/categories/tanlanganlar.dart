import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
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

class _TanlanganlarItemState extends State<TanlanganlarItem>
    with WidgetsBindingObserver {
  bool isShowing = false;
  bool isReaded = false;
  bool isSaved = false;

  @override
  void initState() {
    debugPrint(widget.index.toString());
    //// verse_id boyicha readed saved
    super.initState();
    if (widget.index >= 0 && widget.index < widget.savedOyats.length) {
      isReaded = widget.savedOyats[widget.index].isReaded;
      isSaved = widget.savedOyats[widget.index].isSaved;
    } else {
      isReaded = false;
      isSaved = false;
    }
    debugPrint("$isSaved SALOM");
    debugPrint("$isReaded ssaaaaaaaaaaalllllloooommmm");
    debugPrint("${widget.index} index item coming");
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
        "${widget.state.getSavedOyats[widget.index].suraId}".padLeft(3, '0');
    String juzNumber = "${widget.state.getSavedOyats[widget.index].verseNumber}"
        .padLeft(3, '0');
    debugPrint("$suraNum SURA NUMBER");
    debugPrint("$juzNumber Juz oyat NUMBER");
    debugPrint(widget.index.toString());

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

  Future<String> _getLocalFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/audio_${widget.state.getSavedOyats[widget.index].verseId}.mp3';
  }

  /// path tanlash kerak

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

                                  debugPrint(isReaded.toString());
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
                                  debugPrint(isSaved.toString());
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
                                  debugPrint('Processing State: $processingState');
                                  debugPrint('Is Playing: $playing');
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
                                              debugPrint('connectivity result');
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
