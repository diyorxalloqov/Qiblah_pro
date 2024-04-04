import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesDetailsPage extends StatefulWidget {
  final NamesDetailsArgument namesDetailsArgument;
  const NamesDetailsPage({super.key, required this.namesDetailsArgument});

  @override
  State<NamesDetailsPage> createState() => _NamesDetailsPageState();
}

class _NamesDetailsPageState extends State<NamesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context, 'ficha_99_names'.tr()),
        body: ListView.builder(
            itemCount:
                widget.namesDetailsArgument.namesBloc.state.namesModel.length,
            itemBuilder: (context, index) {
              return Item(
                  index: index,
                  namesDetailsArgument: widget.namesDetailsArgument);
            }));
  }
}

class Item extends StatefulWidget {
  final NamesDetailsArgument namesDetailsArgument;
  final int index;
  const Item(
      {super.key, required this.index, required this.namesDetailsArgument});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> with WidgetsBindingObserver {
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
    if (state == AppLifecycleState.resumed) {
      player.play();
    }
  }

  Future<void> _init(int index) async {
    final String url = widget
        .namesDetailsArgument.namesBloc.state.namesModel[index].nameAudioLink
        .toString();
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
        error = 'audio_error'.tr();
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
    return '${directory.path}/audio_${widget.index}.mp3';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(12.0),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
          decoration: BoxDecoration(
              color: context.isDark ? containerBlackColor : containerColor,
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            children: [
              const SpaceHeight(),
              Text(
                widget.namesDetailsArgument.namesBloc.state
                    .namesModel[widget.index].nameArabic
                    .toString(),
                style: TextStyle(
                    color: context.isDark ? Colors.white : Colors.black,
                    fontFamily: AppfontFamily.inter.fontFamily,
                    fontSize: AppSizes.size_24,
                    fontWeight: AppFontWeight.w_500),
              ),
              const SpaceHeight(),
              Text(
                widget.namesDetailsArgument.namesBloc.state
                    .namesModel[widget.index].title
                    .toString(),
                style: TextStyle(
                    color: context.isDark ? Colors.white : Colors.black,
                    fontFamily: AppfontFamily.inter.fontFamily,
                    fontSize: AppSizes.size_16,
                    fontWeight: AppFontWeight.w_500),
              ),
              const SpaceHeight(),
              SmallText(
                  text: widget.namesDetailsArgument.namesBloc.state
                      .namesModel[widget.index].translation
                      .toString()),
              const SpaceHeight(),
              Text(
                widget.namesDetailsArgument.namesBloc.state
                    .namesModel[widget.index].description
                    .toString(),
                style: TextStyle(
                  fontSize: AppSizes.size_14,
                  color: smallTextColor,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontWeight: AppFontWeight.w_500,
                ),
              ),
              const SpaceHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'tasbehNamePage',
                          arguments: NamesDetailsArgument(
                              namesBloc: widget.namesDetailsArgument.namesBloc,
                              index: widget.index));
                    },
                    radius: 16.r,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: context.isDark
                          ? circleAvatarBlackColor
                          : circleAvatarColor,
                      child: Center(
                        child: SvgPicture.asset(AppIcon.tasbeh,
                            color: context.isDark ? Colors.white : null),
                      ),
                    ),
                  ),
                  SpaceWidth(width: 18.w),
                  InkWell(
                    onTap: () {
                      FlutterShare.share(title: 'title');
                    },
                    radius: 16.r,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: context.isDark
                          ? circleAvatarBlackColor
                          : circleAvatarColor,
                      child: Center(
                        child: SvgPicture.asset(AppIcon.share,
                            color: context.isDark ? Colors.white : null),
                      ),
                    ),
                  ),
                  SpaceWidth(width: 18.w),
                  StreamBuilder(
                    stream: player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;
                      print('Processing State: $processingState');
                      print('Is Playing: $playing');
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering ||
                          isDownloading) {
                        return CircleAvatar(
                          radius: 16.r,
                          backgroundColor: primaryColor,
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      } else if (playing != true || error.isNotEmpty) {
                        return PlayerIcon(
                          backColor: primaryColor,
                          icon: SvgPicture.asset(AppIcon.play),
                          onTap: () async {
                            if (error.isNotEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(error)));
                              await _init(widget.index);
                              Connectivity()
                                  .onConnectivityChanged
                                  .listen((ConnectivityResult result) {
                                if (result != ConnectivityResult.none) {
                                  print('connectivity result');
                                  setState(() {
                                    error = '';
                                    player.stop();
                                  });
                                }
                              });
                            } else {
                              await _init(widget.index);
                              await player.play();
                            }
                          },
                        );
                      } else if (processingState == ProcessingState.ready ||
                          processingState != ProcessingState.completed) {
                        return PlayerIcon(
                          backColor: primaryColor.withOpacity(0.2),
                          icon: SvgPicture.asset(AppIcon.pause),
                          onTap: () async {
                            player.pause();
                            if (error.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error)),
                              );
                            }
                          },
                        );
                      } else {
                        return PlayerIcon(
                          backColor: primaryColor,
                          icon: const Icon(Icons.replay, color: Colors.white),
                          onTap: () {
                            if (error.isEmpty) {
                              player.seek(Duration.zero);
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
              const SpaceHeight()
            ],
          ),
        ),
      ],
    );
  }
}
