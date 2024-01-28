import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/ui/time_page/time_item_widget.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                /////  logic image change with time
                image: SvgImage.asset(AppIcon.time_bomdod),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              const SpaceHeight(),
              const SpaceHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
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
                            color: iconButtonColor),
                      )),
                  const SpaceWidth(),
                  Text(
                    '06:06',
                    style: TextStyle(
                      color: highTextColorWhite,
                      fontSize: AppSizes.size_42,
                      fontFamily: AppfontFamily.comforta.fontFamily,
                      fontWeight: AppFontWeight.w_700,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Container(
                            width: 28,
                            height: 28,
                            padding: const EdgeInsets.all(2),
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: SvgPicture.asset(AppIcon.share,
                                color: iconButtonColor),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'taqvimPage');
                          },
                          icon: Container(
                            width: 28,
                            height: 28,
                            padding: const EdgeInsets.all(3),
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: SvgPicture.asset(AppIcon.calendar,
                                color: iconButtonColor),
                          )),
                    ],
                  )
                ],
              ),
              const SpaceHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "-01:30:25",
                    style: TextStyle(
                        fontSize: AppSizes.size_16,
                        color: Colors.white,
                        fontFamily: AppfontFamily.inter.fontFamily,
                        fontWeight: AppFontWeight.w_400),
                  ),
                  const SpaceWidth(),
                  Text(
                    "bomdod".tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AppSizes.size_16,
                        fontFamily: AppfontFamily.inter.fontFamily,
                        fontWeight: AppFontWeight.w_400),
                  )
                ],
              ),
              const SpaceHeight(),
              GestureDetector(
                onTap: () {
                  showHomeLocationBottomSheet(context);
                },
                child: Container(
                  width: context.width * 0.38,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Toshkent',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.size_16,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: AppFontWeight.w_400,
                          ),
                        ),
                      ),
                      SvgPicture.asset(AppIcon.edit)
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppIcon.arrowLeft,
                              color: iconButtonColor)),
                      const SpaceWidth(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${'bugun'.tr()}: ${DateFormat('dd.MM.yyyy').format(DateTime.now())}',
                            style: TextStyle(
                              color: smallTextWhiteColor,
                              fontSize: AppSizes.size_16,
                              fontFamily: AppfontFamily.comforta.fontFamily,
                              fontWeight: AppFontWeight.w_700,
                            ),
                          ),
                          Text(
                            '11 Jumarrah, Lorem ipsum',
                            style: TextStyle(
                              color: smallTextWhiteColor,
                              fontSize: AppSizes.size_14,
                              fontFamily: AppfontFamily.comforta.fontFamily,
                              fontWeight: AppFontWeight.w_400,
                            ),
                          ),
                        ],
                      ),
                      const SpaceWidth(),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppIcon.arrowRight1,
                            color: iconButtonColor,
                          ))
                    ],
                  )
                ],
              ),
              SpaceHeight(height: 18.h),
              Container(
                height: 310.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    TimeItem(
                        namozName: 'bomdod'.tr(),
                        time: '06:08',
                        volumeOnTap: () {}),
                    Container(
                      width: double.infinity,
                      color: const Color(0x1905FF2D),
                      child: TimeItem(
                          namozName: 'quyosh'.tr(),
                          time: '06:08',
                          volumeOnTap: () {}),
                    ),
                    TimeItem(
                        namozName: 'peshin'.tr(),
                        time: '06:08',
                        volumeOnTap: () {}),
                    TimeItem(
                        namozName: 'asr'.tr(),
                        time: '06:08',
                        volumeOnTap: () {}),
                    TimeItem(
                        namozName: 'shom'.tr(),
                        time: '06:08',
                        volumeOnTap: () {}),
                    TimeItem(
                        namozName: 'xufton'.tr(),
                        time: '06:08',
                        volumeOnTap: () {}),
                  ],
                ),
              ),
              SpaceHeight(height: context.bottom + 50)
            ],
          ),
        ),
      ),
    );
  }
}
