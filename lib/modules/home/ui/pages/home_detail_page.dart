import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class AllFunctionPage extends StatefulWidget {
  const AllFunctionPage({super.key});

  @override
  State<AllFunctionPage> createState() => _AllFunctionPageState();
}

class _AllFunctionPageState extends State<AllFunctionPage> {
  final List<String> _names = const [
    "Qur'on",
    "Qibla",
    "Qazo counter",
    "Zikr",
    "99 games"
  ];

  final List<String> _icons = const [
    AppIcon.quron,
    AppIcon.qibla,
    AppIcon.qazo_counter,
    AppIcon.zikr,
    AppIcon.Godnames
  ];

  final List<String> _itemPages = const [
    'quron',
    'qibla',
    'qazo',
    'zikr',
    'names'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, "barcha_funksiyalar".tr()),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18),
              margin: EdgeInsets.only(top: 12.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: context.isDark ? containerBlackColor : containerColor),
              child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 18.h, crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, _itemPages[index]),
                      borderRadius: BorderRadius.circular(50.r),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: ShapeDecoration(
                              color: context.isDark
                                  ? xizmatlarItemBlack
                                  : xizmatlarItem,
                              shape: const OvalBorder(
                                  side: BorderSide(
                                      color: Colors.black, width: 0.1)),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                _icons[index],
                                color: context.isDark
                                    ? const Color(0xff6D7379)
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(_names[index])
                        ],
                      ),
                    );
                  }),
            ),
          ),
          const Spacer(flex: 7),
        ],
      ),
    );
  }
}
