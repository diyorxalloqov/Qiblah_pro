import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'News title'),
      body: Column(
        children: [
          const SpaceHeight(),
          const SpaceHeight(),
          Container(
            height: context.height * .3,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.grey.shade300),
          ),
          const SpaceHeight(),
          const SpaceHeight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.visibility_outlined, color: smallTextColor, size: 23),
              const SpaceWidth(),
              SmallText(text: '189,304'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcon.calendar,
                        color: iconGreyColor, width: 20),
                    const SpaceWidth(),
                    SmallText(text: '25.13.2023')
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            child: Column(
              children: [
                Text(
                  '''Lorem Ipsum is simply dummy text of the debugPrinting and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown debugPrinter took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
                  style: TextStyle(
                      fontSize: AppSizes.size_15,
                      fontWeight: AppFontWeight.w_400),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        fixedSize: Size(context.width * 0.7, 48.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r))),
                    child: Center(
                      child: Text(
                        'yuklab_olish'.tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.size_16,
                            fontWeight: AppFontWeight.w_600),
                      ),
                    )),
                const SpaceWidth(),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        )),
                    child: const Column(
                      children: [
                        Icon(Icons.favorite_outline, color: Colors.white),
                        Text(
                          "245",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: AppFontWeight.w_400,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
