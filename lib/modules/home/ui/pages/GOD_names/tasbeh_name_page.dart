import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TasbehNamePage extends StatelessWidget {
  const TasbehNamePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: SvgPicture.asset(AppIcon.arrowLeft),
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
          IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcon.count)),
          IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcon.refresh)),
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset(AppIcon.vibration)),
        ],
      ),
      body: Column(
        children: [
          const SpaceHeight(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              children: [
                const SpaceHeight(),
                const HighText(text: 'الفاتحة'),
                const SpaceHeight(),
                const MediumText(text: 'Allah'),
                const SpaceHeight(),
                const SmallText(text: 'Allah, ediyniy bog'),
                const SpaceHeight(),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
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
                          child: SvgPicture.asset(AppIcon.bookmark),
                        ),
                      ),
                    ),
                    SpaceWidth(width: 18.w),
                    InkWell(
                      onTap: () {},
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
                      onTap: () {},
                      radius: 25.r,
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: primaryColor,
                        child: Center(
                          child: SvgPicture.asset(AppIcon.play),
                        ),
                      ),
                    )
                  ],
                ),
                const SpaceHeight(),
              ],
            ),
          ),
          const SpaceHeight(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r))),
              child: Column(
                children: [
                  const SpaceHeight(),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100.r),
                    child: Container(
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Column(
                        children: [
                          Text('33',
                              style: TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '/33',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SmallText(text: ' | '),
                              Text(
                                'x0',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SpaceHeight(),
                  const SpaceHeight(),
                  Container(
                    height: 82.h,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        primaryColor,
                        primaryColor.withOpacity(0.8),
                        primaryColor
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
