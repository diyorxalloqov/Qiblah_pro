import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesDetailsPage extends StatefulWidget {
  final NamesDetailsArgument namesDetailsArgument;
  const NamesDetailsPage({super.key, required this.namesDetailsArgument});

  @override
  State<NamesDetailsPage> createState() => _NamesDetailsPageState();
}

class _NamesDetailsPageState extends State<NamesDetailsPage>
    with WidgetsBindingObserver {
  final AudioPlayer player =
      AudioPlayer(); // audio downloadni tasbehga qo'shish
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
    final String url = widget.namesDetailsArgument.namesBloc.state
        .namesModel[widget.namesDetailsArgument.index].nameAudioLink
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
        error = 'Audio yuklashda xatolik';
      });
      try {
        final Response response =
            await Dio(BaseOptions(connectTimeout: const Duration(seconds: 5)))
                .get("https://www.google.com/");
        if (response.statusCode == 200) {
          error = '';
          setState(() {});
          print("hello");
          await _downloadAudio(url, localFilePath);
        } else {
          error = "Iltimos internetingizni tekshiring";
        }
      } on Exception catch (e) {
        print('exeption');
      }
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
    return '${directory.path}/audio_${widget.namesDetailsArgument.index}.mp3';
  }

  @override
  Widget build(BuildContext context) {
    NamesBloc bloc = widget.namesDetailsArgument.namesBloc;
    NamesData data = bloc.state.namesModel[widget.namesDetailsArgument.index];
    return Scaffold(
        appBar: customAppbar(context, 'name'.tr()),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              decoration: BoxDecoration(
                  color: context.isDark ? containerBlackColor : containerColor,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  const SpaceHeight(),
                  HighText(text: data.nameArabic.toString()),
                  const SpaceHeight(),
                  MediumText(text: data.title.toString()),
                  const SpaceHeight(),
                  SmallText(text: data.translation.toString()),
                  const SpaceHeight(),
                  Text(
                    data.description.toString(),
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
                              arguments: widget.namesDetailsArgument);
                        },
                        radius: 25.r,
                        child: CircleAvatar(
                          radius: 25.r,
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
                        radius: 25.r,
                        child: CircleAvatar(
                          radius: 25.r,
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
                              radius: 25.r,
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)));
                                  await _init();
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
                                  await _init();
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
                              icon:
                                  const Icon(Icons.replay, color: Colors.white),
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
        ));
  }
}
