import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TaqvimPage extends StatefulWidget {
  const TaqvimPage({super.key});

  @override
  State<TaqvimPage> createState() => _TaqvimPageState();
}

class _TaqvimPageState extends State<TaqvimPage> {
  List table = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 220.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(AppImages.taqvim_back), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SpaceHeight(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            width: 28,
                            height: 28,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF4F7FA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: SvgPicture.asset(AppIcon.arrowLeft),
                          )),
                      const SpaceWidth(),
                      Text(
                        "namoz_taqvimi".tr(),
                        style: TextStyle(
                          fontSize: AppSizes.size_18,
                          fontFamily: AppfontFamily.comforta.fontFamily,
                          fontWeight: AppFontWeight.w_700,
                        ),
                      ),
                      const SpaceWidth(),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppIcon.share, width: 30))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcon.calendar,
                          color: primaryColor, width: 20),
                      const SpaceWidth(),
                      Text(
                        'Dekabr 2023, Jumada 1445',
                        style: TextStyle(
                          fontSize: AppSizes.size_16,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: AppFontWeight.w_500,
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcon.location, width: 20),
                      const SpaceWidth(),
                      Text(
                        'Toshkent',
                        style: TextStyle(
                          fontSize: AppSizes.size_16,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: AppFontWeight.w_500,
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(),
                  Text(
                    'namoz_taqvimi_promt'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppSizes.size_10,
                        fontFamily: AppfontFamily.inter.fontFamily,
                        fontWeight: AppFontWeight.w_400,
                        color: smallTextColor),
                  ),
                ],
              ),
            ),
          ),
          const SpaceHeight(),
          const SpaceHeight(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: Table(
                border: TableBorder.symmetric(
                    outside: BorderSide.none,
                    inside: BorderSide(color: tableColor, width: 1)),
                children: List.generate(
                    31,
                    (index) => TableRow(
                            children: List.generate(
                          7,
                          (index) => TableCell(
                              child: Center(child: Text(table[index]))),
                        )))),
          ),
          const SpaceHeight()
        ],
      ),
    );
  }
}
