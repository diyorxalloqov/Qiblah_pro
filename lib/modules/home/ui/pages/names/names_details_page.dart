import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesDetailsPage extends StatefulWidget {
  final NamesDetailsArgument namesDetailsArgument;
  const NamesDetailsPage({super.key, required this.namesDetailsArgument});

  @override
  State<NamesDetailsPage> createState() => _NamesDetailsPageState();
}

class _NamesDetailsPageState extends State<NamesDetailsPage>
    with WidgetsBindingObserver {
  final AudioPlayer player = AudioPlayer();
  String error = '';

  @override
  void initState() {
    _init();
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

  Future<void> _init() async {
    String url = widget.namesDetailsArgument.namesBloc.state
        .namesModel[widget.namesDetailsArgument.index].nameAudioLink
        .toString();
    print(
        "${widget.namesDetailsArgument.index + 1} INDEX OF SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('STREAM ERROR $e');
    });
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    } catch (e) {
      print("Error loading audio source: $e");
      error = 'Iltimos internetingizni tekshiring';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
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
                          if (processingState == ProcessingState.loading ||
                              processingState == ProcessingState.buffering) {
                            if (error.isNotEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(error)));
                            }
                            return PlayerIcon(
                              backColor: primaryColor,
                              icon: const CircularProgressIndicator.adaptive(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white)),
                              onTap: () {},
                            );
                          } else if (playing != true || error.isNotEmpty) {
                            return PlayerIcon(
                              backColor: primaryColor,
                              icon: SvgPicture.asset(AppIcon.play),
                              onTap: () {
                                player.play();
                                if (error.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)));
                                }
                              },
                            );
                          } else if (processingState == ProcessingState.ready ||
                              processingState != ProcessingState.completed) {
                            return PlayerIcon(
                              backColor: primaryColor.withOpacity(0.2),
                              icon: SvgPicture.asset(AppIcon.pause),
                              onTap: () {
                                player.pause();
                                if (error.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)));
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
                                });
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
