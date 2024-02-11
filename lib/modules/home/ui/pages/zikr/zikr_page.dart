import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class ZikrPage extends StatefulWidget {
  const ZikrPage({super.key});

  @override
  State<ZikrPage> createState() => _ZikrPageState();
}

class _ZikrPageState extends State<ZikrPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<String> _titles = const [
    'ertalabki_zikrlar',
    "tungi_zikrlar",
    'allohdan_sorash',
    "kerakli_duolar",
    "asmaul_husna",
    "tanlangan_zikrlar"
  ];
  final List<String> _icons = const [
    AppImages.ertalabki_zikr,
    AppImages.tungi_zikr,
    AppImages.allohdan_sorash,
    AppImages.kerakli_duolar,
    AppImages.asmaul_husna,
    AppImages.tanlangan_zkir
  ];

  final List<Color> _colors = [
    ertalabki_zikr,
    tungi_zikrlar,
    allohdan_sorash,
    kerakli_duolar,
    asmaul_husna,
    tanlangan_zikrlar
  ];

  double percent = 0.53;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context, 'zikr'.tr()),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180.h,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          _currentPage = value;
                          setState(() {});
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Dekabr uchun 1,000,000 savolat chellen...",
                                  style: TextStyle(
                                      fontWeight: AppFontWeight.w_600,
                                      fontSize: AppSizes.size_16),
                                ),
                                const SpaceHeight(),
                                SmallText(text: 'qoldi'.tr()),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MediumText(text: '4 000 000'),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          color: Colors.grey,
                                        ),
                                        SpaceWidth(),
                                        Text('356')
                                      ],
                                    ),
                                  ],
                                ),
                                const SpaceHeight(),
                                LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  backgroundColor: const Color(0xffF1F1FA),
                                  progressColor: primaryColor,
                                  animateFromLastPercent: true,
                                  percent: percent,
                                  lineHeight: 15,
                                  trailing: Text('${(percent * 100).toInt()}%'),
                                  barRadius: const Radius.circular(47),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: 5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // i coming backend data length
                        for (int i = 0; i < 5; i++)
                          AnimatedContainer(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: _currentPage == i
                                  ? primaryColor
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            width: 10,
                            height: 10,
                            duration: const Duration(milliseconds: 300),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'zikrMain');
                        },
                        child: Container(
                          height: 170.h,
                          width: 154.w,
                          decoration: BoxDecoration(
                              color: _colors[index],
                              image: DecorationImage(
                                  image: AssetImage(_icons[index]),
                                  alignment: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(18.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              _titles[index].tr(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontFamily: AppfontFamily.inter.fontFamily,
                                  fontSize: AppSizes.size_18,
                                  fontWeight: AppFontWeight.w_500),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
