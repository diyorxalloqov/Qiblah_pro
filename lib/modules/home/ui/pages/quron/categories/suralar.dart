import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/global/widgets/error_screen.dart';

class SuralarlarPage extends StatefulWidget {
  const SuralarlarPage({super.key});

  @override
  State<SuralarlarPage> createState() => _SuralarlarPageState();
}

class _SuralarlarPageState extends State<SuralarlarPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Add the event only when the page is active
    context.read<QuronBloc>().add(QuronSurahGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuronBloc, QuronState>(
      builder: (context, state) {
        if (state.status == ActionStatus.isLoading) {
          return const LoadingPage();
        } else if (state.status == ActionStatus.isSuccess) {
          return ListView.builder(
              itemCount: state.quronModel.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CardItem(index: 1, quronState: state);
                } else {
                  return CardItem(index: index + 1, quronState: state);
                }
              });
        }
        return NoNetworkScreen(
            onTap: () => context
                .read<QuronBloc>()
                .add(const SurahGetFromApi(pageItem: 1, limit: 114)));
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final int index;
  final QuronState quronState;
  const CardItem({super.key, required this.index, required this.quronState});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        onTap: () {
          debugPrint("$index tapped index is");
          context.read<QuronBloc>().add(GetOyatFromDB(
              index: index,
              suraLength:
                  quronState.quronModel[index - 1].suraVerseCount ?? 0));
          Navigator.pushNamed(context, 'suralarDetails',
              arguments: SuralarDetailsPageArguments(
                  index: index,
                  suraVerseCount:
                      quronState.quronModel[index - 1].suraVerseCount ?? 0,
                  suraName: quronState.quronModel[index - 1].name ?? '',
                  suraId: int.parse(
                      quronState.quronModel[index - 1].suraId ?? '0')));
        },
        leading: Container(
          width: 28,
          height: 28,
          decoration: ShapeDecoration(
            color: primaryColor,
            shape: const StarBorder(
              points: 8,
              innerRadiusRatio: 0.84,
            ),
          ),
          child: Center(
              child: Text(
            '$index',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: AppFontWeight.w_500),
          )),
        ),
        title: Text(
          quronState.quronModel[index - 1].name ?? '',
          style: TextStyle(
            color: context.isDark ? Colors.white : Colors.black,
            fontSize: AppSizes.size_16,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
        subtitle: Text(
          '${quronState.quronModel[index - 1].suraVerseCount ?? ''} ${('oyat').tr()}',
          style: TextStyle(
              color: context.isDark ? const Color(0xffE3E7EA) : smallTextColor,
              fontSize: AppSizes.size_12,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_400),
        ),
        trailing: Text(
          quronState.quronModel[index - 1].suraNameArabic ?? '',
          style: TextStyle(
            color: context.isDark ? const Color(0xffE3E7EA) : arabicTextColor,
            fontSize: AppSizes.size_24,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
      ),
    );
  }
}
