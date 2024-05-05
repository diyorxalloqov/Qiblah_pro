import 'package:pie_chart/pie_chart.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/blocs/qazo/qazo_bloc.dart';
import 'package:qiblah_pro/modules/home/ui/widgets/qazo_card_widget.dart';

class QazoPage extends StatefulWidget {
  const QazoPage({super.key});

  @override
  State<QazoPage> createState() => _QazoPageState();
}

class _QazoPageState extends State<QazoPage> {
  late QazoBloc qazobloc;
  @override
  void initState() {
    qazobloc = QazoBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'ficha_qazo'.tr()),
      body: BlocProvider(
        create: (context) => qazobloc,
        child: BlocBuilder<QazoBloc, QazoState>(
          builder: (context, state) {
            Map<String, double> dataMap = {
              "bomdod": state.bomdod.toDouble(),
              "peshin": state.peshin.toDouble(),
              "asr": state.asr.toDouble(),
              "shom": state.shom.toDouble(),
              "xufton": state.xufton.toDouble()
            };
            return SafeArea(
              child: Column(
                children: [
                  const SpaceHeight(),
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 500),
                    chartLegendSpacing: 32,
                    chartRadius: context.width / 2,
                    chartType: ChartType.disc,
                    colorList: qazoDiagramColor,
                    ringStrokeWidth: 32,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: false,
                      legendShape: BoxShape.circle,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      chartValueBackgroundColor: Colors.black,
                      showChartValues: false,
                      showChartValuesInPercentage: false,
                    ),
                  ),
                  const SpaceHeight(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${('jami').tr()}: ",
                        style: TextStyle(
                          color: smallTextColor,
                          fontSize: AppSizes.size_16,
                          fontFamily: AppfontFamily.inter.fontFamily,
                          fontWeight: AppFontWeight.w_500,
                        ),
                      ),
                      Text(
                        state.overall.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppfontFamily.inter.fontFamily,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SpaceHeight(),
                  QazoCardWidget(
                    color: qazoDiagramColor[0],
                    qazoCount: state.bomdod.toString(),
                    title: 'bomdod'.tr(),
                    increment: () =>
                        qazobloc.add(const BomdodEvent(isIncrement: true)),
                    decrement: () =>
                        qazobloc.add(const BomdodEvent(isIncrement: false)),
                  ),
                  QazoCardWidget(
                    color: qazoDiagramColor[1],
                    qazoCount: state.peshin.toString(),
                    title: 'peshin'.tr(),
                    increment: () =>
                        qazobloc.add(const PeshinEvent(isIncrement: true)),
                    decrement: () =>
                        qazobloc.add(const PeshinEvent(isIncrement: false)),
                  ),
                  QazoCardWidget(
                    color: qazoDiagramColor[2],
                    qazoCount: state.asr.toString(),
                    title: 'asr'.tr(),
                    increment: () =>
                        qazobloc.add(const AsrEvent(isIncrement: true)),
                    decrement: () =>
                        qazobloc.add(const AsrEvent(isIncrement: false)),
                  ),
                  QazoCardWidget(
                    color: qazoDiagramColor[3],
                    qazoCount: state.shom.toString(),
                    title: 'shom'.tr(),
                    increment: () =>
                        qazobloc.add(const ShomEvent(isIncrement: true)),
                    decrement: () =>
                        qazobloc.add(const ShomEvent(isIncrement: false)),
                  ),
                  QazoCardWidget(
                    color: qazoDiagramColor[4],
                    qazoCount: state.xufton.toString(),
                    title: 'xufton'.tr(),
                    increment: () =>
                        qazobloc.add(const XuftonEvent(isIncrement: true)),
                    decrement: () =>
                        qazobloc.add(const XuftonEvent(isIncrement: false)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
