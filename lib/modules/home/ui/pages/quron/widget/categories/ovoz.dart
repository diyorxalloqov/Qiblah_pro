import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class Ovoz extends StatefulWidget {
  const Ovoz({super.key});

  @override
  State<Ovoz> createState() => _EkranState();
}

class _EkranState extends State<Ovoz> {
  bool auto = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ovoz'.tr(),
            style: TextStyle(
                fontSize: AppSizes.size_18,
                fontFamily: AppfontFamily.inter.fontFamily,
                fontWeight: AppFontWeight.w_400,
                color: primaryColor),
          ),
          const SpaceHeight(),
          Text(
            "${('qiroat_egasi').tr()}:",
            style: TextStyle(
              fontSize: AppSizes.size_16,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_400,
            ),
          ),
          const SpaceHeight(),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                        width: 135.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey, width: 1)),
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.only(left: 12),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(),
                            SizedBox(height: 5),
                            Text(
                              'Shayx muhammad sodiq',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1D2124),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            SizedBox(height: 5),
                            SmallText(text: 'O’zbek')
                          ],
                        ),
                      ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Авто-прокрутка',
                style: TextStyle(
                  fontSize: AppSizes.size_16,
                  fontFamily: AppfontFamily.inter.fontFamily,
                  fontWeight: AppFontWeight.w_400,
                ),
              ),
              Switch.adaptive(
                  value: auto,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.white,
                  onChanged: (v) {
                    auto = v;
                    setState(() {});
                  })
            ],
          ),
        ],
      ),
    );
  }
}
