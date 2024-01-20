import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String date = '';

  @override
  Widget build(BuildContext context) {
    DateTime.now().minute >= 10
        ? date = DateTime.now().minute.toString()
        : '0${DateTime.now().minute}';
    return Container(
      color: scaffoldColor,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
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
                        MediumText(
                            text: '${('assalom_alekum').tr()}, Sherzod!'),
                        SizedBox(height: 5.h),
                        SmallText(text: "ibodatlaringiz_qabul_bolsin".tr())
                      ],
                    ),
                  ),
                  Container(
                    height: 150.h,
                    padding:
                        EdgeInsets.only(left: 18.w, right: 18.w, top: 15.h),
                    margin: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: LinearGradient(colors: [
                          const Color(0xff6D7379).withOpacity(0.15),
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
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SpaceHeight(),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "barchasini_korish".tr(),
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 6.h),
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
                    padding:
                        EdgeInsets.only(bottom: 18.h, top: 18.h, left: 12.w),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "bizning_xizmatlar".tr(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "barchasini_korish".tr(),
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
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
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 18.w),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40.r,
                                          backgroundColor:
                                              const Color(0xffEAEFF4),
                                          child: Center(
                                            child:
                                                SvgPicture.asset(AppIcon.apple),
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        const Text("salom")
                                      ],
                                    ),
                                  );
                                }))
                      ],
                    ),
                  ),
                ],
              );
            }
            if (index == 1) {
              return Column(
                children: [
                  SpaceHeight(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "kunlik_ilm".tr(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: context.height * 0.32,
                              width: context.width * 0.1,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                return Text("hello");
                              }),
                            ),
                            SizedBox(
                              height: context.height * 0.32,
                              width: context.width * 0.8,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                return CardWidget();
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
