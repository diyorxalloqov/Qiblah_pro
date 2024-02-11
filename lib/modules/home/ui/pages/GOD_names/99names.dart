import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/blocs/names/names_bloc.dart';
import 'package:qiblah_pro/modules/home/ui/widgets/shimmer/names_shimmer.dart';

class NamesPage extends StatefulWidget {
  const NamesPage({super.key});

  @override
  State<NamesPage> createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  late NamesBloc namesBloc;
  @override
  void initState() {
    namesBloc = NamesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'names'.tr()),
      body: BlocProvider.value(
        value: namesBloc,
        child: BlocBuilder<NamesBloc, NamesState>(
          builder: (context, state) {
            if (state.status == ActionStatus.isLoading) {
              return const NamesShimmer();
            }
            if (state.status == ActionStatus.isSuccess) {
              return ListView.builder(
                  itemCount: state.namesModel!.data!.length,
                  itemBuilder: (context, index) => CardItem1(
                      index: index, namesBloc: namesBloc, state: state));
            }
            return Center(
              child: Text(state.error),
            );
          },
        ),
      ),
    );
  }
}

class CardItem1 extends StatelessWidget {
  final int index;
  final NamesState state;
  final NamesBloc namesBloc;
  const CardItem1(
      {super.key,
      required this.index,
      required this.namesBloc,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        onTap: () {
          Navigator.of(context).pushNamed('namesDetailsPage',
              arguments:
                  NamesDetailsArgument(namesBloc: namesBloc, index: index));
        },
        leading: Container(
          width: 28,
          height: 28,
          decoration: ShapeDecoration(
            color: primaryColor,
            shape: const StarBorder(points: 8, innerRadiusRatio: 0.84),
          ),
          child: Center(
              child: Text(
            '${index + 1}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: AppFontWeight.w_500),
          )),
        ),
        title: Text(
          state.namesModel?.data?[index].title.toString() ?? '',
          style: TextStyle(
            fontSize: AppSizes.size_16,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
        subtitle: Text(
          state.namesModel?.data?[index].translation.toString() ?? '',
          style: TextStyle(
              color: smallTextColor,
              fontSize: AppSizes.size_12,
              fontFamily: AppfontFamily.inter.fontFamily,
              fontWeight: AppFontWeight.w_400),
        ),
        trailing: Text(
          state.namesModel?.data?[index].nameArabic.toString() ?? '',
          style: TextStyle(
            color: arabicTextColor,
            fontSize: AppSizes.size_24,
            fontFamily: AppfontFamily.inter.fontFamily,
            fontWeight: AppFontWeight.w_500,
          ),
        ),
      ),
    );
  }
}
