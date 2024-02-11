import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NamesDetailsPage extends StatefulWidget {
  final NamesDetailsArgument namesDetailsArgument;
  // final String descr;
  const NamesDetailsPage({super.key, required this.namesDetailsArgument});

  @override
  State<NamesDetailsPage> createState() => _NamesDetailsPageState();
}

class _NamesDetailsPageState extends State<NamesDetailsPage> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    NamesBloc bloc = widget.namesDetailsArgument.namesBloc;
    return Scaffold(
        appBar: customAppbar(context, 'name'.tr()),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Column(
                children: [
                  const SpaceHeight(),
                  HighText(
                      text: bloc
                              .state
                              .namesModel
                              ?.data?[widget.namesDetailsArgument.index]
                              .nameArabic ??
                          ''),
                  const SpaceHeight(),
                  MediumText(
                      text: bloc.state.namesModel
                              ?.data?[widget.namesDetailsArgument.index].title
                              .toString() ??
                          ''),
                  const SpaceHeight(),
                  const SmallText(text: 'Allah, ediyniy bog'),
                  const SpaceHeight(),
                  Text(
                    bloc
                            .state
                            .namesModel
                            ?.data?[widget.namesDetailsArgument.index]
                            .description
                            .toString() ??
                        '',
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
                          Navigator.pushNamed(context, 'tasbehNamePage');
                        },
                        radius: 25.r,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundColor: circleAvatarColor,
                          child: Center(
                            child: SvgPicture.asset(AppIcon.tasbeh),
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
                          backgroundColor: circleAvatarColor,
                          child: Center(
                            child: SvgPicture.asset(AppIcon.share),
                          ),
                        ),
                      ),
                      SpaceWidth(width: 18.w),
                      InkWell(
                        onTap: () async {
                          _isPlaying = !_isPlaying;
                          setState(() {});
                          bloc.add(PlayNameEvent(
                              isPlaying: _isPlaying,
                              url: bloc
                                      .state
                                      .namesModel
                                      ?.data?[widget.namesDetailsArgument.index]
                                      .nameAudioLink ??
                                  ''));
                        },
                        radius: 25.r,
                        child: BlocProvider(
                          create: (context) => NamesBloc(),
                          child: BlocListener<NamesBloc, NamesState>(
                            listener: (context, state) {
                              !state.isPlaying ? _isPlaying = false : true;
                              setState(() {});
                            },
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundColor: _isPlaying
                                  ? primaryColor.withOpacity(0.3)
                                  : primaryColor,
                              child: Center(
                                child: SvgPicture.asset(
                                  _isPlaying ? AppIcon.pause : AppIcon.play,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
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
