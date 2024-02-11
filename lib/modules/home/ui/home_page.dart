import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String date = '';

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
  build(BuildContext context) {
    DateTime.now().minute >= 10
        ? date = "${DateTime.now().minute}"
        : '0${DateTime.now().minute}';
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 5.h),
                MediumText(text: '${('assalom_alekum').tr()}, Sherzod!'),
                SizedBox(height: 5.h),
                SmallText(text: "ibodatlaringiz_qabul_bolsin".tr())
              ],
            ),
          ),
          Container(
            height: 150.h,
            padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(colors: [
                  smallTextColor.withOpacity(0.15),
                  const Color(0xff7CD722).withOpacity(0.25),
                  const Color(0xff0A9D4E).withOpacity(0.2)
                ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${DateTime.now().hour.toString()}:$date",
                      style: TextStyle(
                        fontSize: AppSizes.size_24,
                        color: highTextColor,
                        fontWeight: AppFontWeight.w_700,
                      ),
                    ),
                    const SpaceHeight(),
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        "${("asr").tr()} 1 ${("soat").tr()}, 32 ${("daqiqadan_song").tr()}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Color(0xFF6D7379),
                          fontSize: AppSizes.size_12,
                          fontWeight: AppFontWeight.w_400,
                        ),
                      ),
                    ),
                    const SpaceHeight(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'TimePage');
                      },
                      child: Row(
                        children: [
                          Text(
                            "barchasini_korish".tr(),
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: AppSizes.size_14,
                                fontWeight: AppFontWeight.w_700),
                          ),
                          const SpaceWidth(),
                          SvgPicture.asset(AppIcon.arrowRight,
                              color: primaryColor, width: 30.w)
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F6DC).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Row(
                        children: [
                          SmallText(text: 'Toshkent'),
                          const SpaceWidth(),
                          SvgPicture.asset(AppIcon.location)
                        ],
                      ),
                    ),
                    SvgPicture.asset(AppIcon.moshid, width: 100.w),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: context.height * 0.23,
            padding: EdgeInsets.only(bottom: 18.h, top: 18.h, left: 12.w),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "bizning_xizmatlar".tr(),
                      style: TextStyle(
                          color: highTextColor,
                          fontSize: AppSizes.size_16,
                          fontWeight: AppFontWeight.w_700),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, 'detailPage'),
                      child: Row(
                        children: [
                          Text(
                            "barchasini_korish".tr(),
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: AppSizes.size_14,
                                fontWeight: AppFontWeight.w_700),
                          ),
                          const SpaceWidth(),
                          SvgPicture.asset(AppIcon.arrowRight,
                              color: primaryColor, width: 30.w),
                          const SpaceWidth(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 18.w),
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, _itemPages[index]),
                              borderRadius: BorderRadius.circular(50.r),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      color: xixmatlarItem,
                                      shape: const OvalBorder(
                                          side: BorderSide(
                                              color: Colors.black, width: 0.1)),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(_icons[index]),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(_names[index])
                                ],
                              ),
                            ),
                          );
                        })),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Text(
              "kunlik_ilm".tr(),
              style: const TextStyle(
                fontSize: AppSizes.size_16,
                fontWeight: AppFontWeight.w_700,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SpaceHeight(height: context.height * 0.15),
                  Column(
                    children: List.generate(
                        11 + 1,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 18,
                                    width: 18,
                                    decoration: const ShapeDecoration(
                                        color: Color(0xffD1F3E1),
                                        shape: OvalBorder()),
                                  ),
                                  Dash(
                                    dashThickness: 2,
                                    direction: Axis.vertical,
                                    length: 230,
                                    /*  */
                                    dashBorderRadius: 10,
                                    dashLength: 10,
                                    dashGap: 10,
                                    dashColor: primaryColor,
                                  ),
                                ],
                              ),
                            )),
                  ),
                ],
              ),
              Column(
                children: List.generate(
                    11,
                    (index) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (index == 0)
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'newsDetail');
                                },
                                borderRadius: BorderRadius.circular(12.r),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: context.bottom + 10),
                                  height: context.height * 0.3,
                                  width: context.width * 0.85,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.grey),
                                ),
                              ),
                            const CardWidget(),
                          ],
                        )),
              )
            ],
          )
        ],
      ),
    );
  }
}
