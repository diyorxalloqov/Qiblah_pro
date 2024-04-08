import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class AllFunctionPage extends StatefulWidget {
  const AllFunctionPage({super.key});

  @override
  State<AllFunctionPage> createState() => _AllFunctionPageState();
}

class _AllFunctionPageState extends State<AllFunctionPage> {
  final List<String> _names = const [
    "quron",
    "ficha_qibla",
    "ficha_qazo",
    "ficha_zikr",
    "ficha_99_names"
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
        margin: EdgeInsets.only(
            top: 12.h, bottom: MediaQuery.viewPaddingOf(context).bottom + 460),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: context.isDark ? containerBlackColor : containerColor),
        child: GridView.builder(
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 18.h, crossAxisCount: 4),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.pushNamed(context, _itemPages[index]),
                borderRadius: BorderRadius.circular(50.r),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: ShapeDecoration(
                        color:
                            context.isDark ? xizmatlarItemBlack : xizmatlarItem,
                        shape: const OvalBorder(side: BorderSide.none),
                      ),
                      child: Center(
                        child: SvgPicture.asset(_icons[index],
                            width: 40,
                            color: context.isDark ? Colors.white70 : null),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(_names[index].tr(), textAlign: TextAlign.center)
                  ],
                ),
              );
            }),
      ),
    );
  }
}
