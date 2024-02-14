import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TasbehNamePage extends StatefulWidget {
  final NamesDetailsArgument namesDetailsArgument;
  const TasbehNamePage({super.key, required this.namesDetailsArgument});

  @override
  State<TasbehNamePage> createState() => _TasbehNamePageState();
}

class _TasbehNamePageState extends State<TasbehNamePage>
    with WidgetsBindingObserver {
  bool _isTap = false;
  late ZikrBloc zikrBloc;
  int index = 0;
  String _selectedItem = ZikrBloc.tasbehSizes[0].toString();
  bool isVibration = false;
  final AudioPlayer player = AudioPlayer();
  String error = '';

  @override
  void initState() {
    zikrBloc = ZikrBloc();
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    NamesBloc bloc = widget.namesDetailsArgument.namesBloc;
    NamesData data = bloc.state.namesModel[widget.namesDetailsArgument.index];
    return BlocProvider.value(
      value: zikrBloc,
      child: BlocBuilder<ZikrBloc, ZikrState>(
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
                'zikr'.tr(),
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
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList();
                  },
                ),
                IconButton(
                    onPressed: () {
                      zikrBloc.add(RefreshZikrEvent());
                      setState(() {});
                    },
                    icon: SvgPicture.asset(AppIcon.refresh,
                        color: context.isDark ? Colors.white : null)),
                IconButton(
                    onPressed: () {
                      isVibration = !isVibration;
                      setState(() {});
                      zikrBloc
                          .add(ZikrVibrationEvent(isVibration: isVibration));
                    },
                    icon: SvgPicture.asset(AppIcon.vibration,
                        color: context.isDark ? Colors.white : null)),
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(12.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  decoration: BoxDecoration(
                      color:
                          context.isDark ? containerBlackColor : containerColor,
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: AppSizes.size_14,
                            color: smallTextColor,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: AppFontWeight.w_500),
                      ),
                      const SpaceHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            radius: 25.r,
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundColor: context.isDark
                                  ? circleAvatarBlackColor
                                  : circleAvatarColor,
                              child: Center(
                                child: SvgPicture.asset(AppIcon.bookmark,
                                    color:
                                        context.isDark ? Colors.white : null),
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
                                    color:
                                        context.isDark ? Colors.white : null),
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
                              final playing = playerState?.playing;
                              if (processingState == ProcessingState.loading ||
                                  processingState ==
                                      ProcessingState.buffering) {
                                return PlayerIcon(
                                  backColor: primaryColor,
                                  icon:
                                      const CircularProgressIndicator.adaptive(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white)),
                                  onTap: () {},
                                );
                              } else if (playing != true || error.isNotEmpty) {
                                return PlayerIcon(
                                  backColor: primaryColor,
                                  icon: SvgPicture.asset(AppIcon.play),
                                  onTap: () {
                                    player.play();
                                  },
                                );
                              } else if (processingState ==
                                      ProcessingState.ready ||
                                  processingState !=
                                      ProcessingState.completed) {
                                return PlayerIcon(
                                  backColor: primaryColor.withOpacity(0.2),
                                  icon: SvgPicture.asset(AppIcon.pause),
                                  onTap: () {
                                    player.pause();
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
                const SpaceHeight(),
                Expanded(
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
                          padding: const EdgeInsets.all(30.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Column(
                            children: [
                              Text(zikrBloc.currentZikr.toString(),
                                  style: const TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "/$_selectedItem",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SmallText(text: ' | '),
                                  Text(
                                    'x${zikrBloc.currentZikrOuterCount ?? 0}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                            zikrBloc.add(IncrementZikr(index: index));
                            setState(() {});
                            if (_isTap) {
                              Future.delayed(const Duration(milliseconds: 300),
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
