import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/bloc/on_boarding_bloc.dart';

showLangBottomSheet(BuildContext c) {
  showModalBottomSheet(
    context: c,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) => const LangBottomSheet(),
  );
}

class LangBottomSheet extends StatefulWidget {
  const LangBottomSheet({Key? key}) : super(key: key);

  @override
  State<LangBottomSheet> createState() => _LangBottomSheetState();
}

class _LangBottomSheetState extends State<LangBottomSheet> {
  late String selectedLang;

  Future<void> _loadSelectedLanguage() async {
    selectedLang = context.read<OnBoardingBloc>().state.language;
  }

  @override
  void initState() {
    _loadSelectedLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: MediumText(text: 'tilni_ozgartirish'.tr()),
        ),
        Container(
          color: scaffoldColor,
          child: Column(
            children: [
              buildLanguageOption("O'zbekcha", 'uz'),
              buildLanguageOption('Kirilcha', 'ru'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () async {
                    context
                        .read<OnBoardingBloc>()
                        .add(ChangeLanguageEvent(selectedLang));

                    context.setLocale(Locale(selectedLang));

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'saqlash'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildLanguageOption(String languageName, String languageCode) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12.0),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: selectedLang == languageCode
            ? primaryColor.withOpacity(0.2)
            : Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedLang = languageCode;
          });
        },
        child: Text(
          languageName,
          style: TextStyle(
            color: selectedLang == languageCode ? primaryColor : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
