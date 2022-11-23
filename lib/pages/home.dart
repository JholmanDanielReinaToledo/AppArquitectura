import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final oCcy = NumberFormat("\$#,##0", "en_US");

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime fechaInicial;
  final controller = GroupButtonController();

  @override
  void initState() {
    super.initState();
    setState(() {
      fechaInicial = DateTime.now().subtract(Duration(days: 500000));
      controller.selectIndex(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    final entriesProvider = Provider.of<EntryListProvider>(context);
    final spendsProvider = Provider.of<SpentListProvider>(context);
    print(FirebaseAuth.instance.currentUser?.uid);

    List<Entry> entradas = [];
    int totalEntradas = 0;

    List<Spent> salidas = [];
    int totalSalidas = 0;

    for (Entry entry in entriesProvider.entries) {
      if (entry.date.isAfter(fechaInicial)) {
        entradas.add(entry);
        totalEntradas = totalEntradas + entry.value;
      }
    }

    for (Spent spent in spendsProvider.spents) {
      if (spent.date.isAfter(fechaInicial)) {
        salidas.add(spent);
        totalSalidas = totalSalidas + spent.value;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerPropio(),
      appBar: AppBar(
        backgroundColor: Config.blue,
        title: Text('FinTech'),
      ),
      body: FooterView(
        footer: Footer(
          backgroundColor: Config.blue,
          padding: EdgeInsets.all(5),
          child: Center(
            child: Text(
              'Disponible ${oCcy.format(totalEntradas - totalSalidas)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                GroupButton(
                  controller: controller,
                  isRadio: true,
                  options: GroupButtonOptions(
                    selectedColor: Config.blue,
                  ),
                  onSelected: (String, int, bool) {
                    switch (int) {
                      case 0:
                        setState(() {
                          fechaInicial =
                              DateTime.now().subtract(Duration(days: 1));
                        });
                        break;
                      case 1:
                        setState(() {
                          fechaInicial =
                              DateTime.now().subtract(Duration(days: 7));
                        });
                        break;
                      case 2:
                        setState(() {
                          fechaInicial =
                              DateTime.now().subtract(Duration(days: 15));
                        });
                        break;
                      case 3:
                        setState(() {
                          fechaInicial =
                              DateTime.now().subtract(Duration(days: 30));
                        });
                        break;
                      case 4:
                        setState(() {
                          fechaInicial =
                              DateTime.now().subtract(Duration(days: 500000));
                        });
                        break;
                      default:
                    }
                  },
                  buttons: ["1 dia", "7 dias", "15 dias", "30 dias", "todos"],
                ),
                SfCircularChart(
                  annotations: [
                    CircularChartAnnotation(),
                  ],
                  series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ChartData, String>(
                      dataSource: [
                        ChartData(
                          'Gastos',
                          totalSalidas.toDouble(),
                          Color.fromARGB(19, 199, 199, 199),
                        ),
                        ChartData(
                          'Disponible',
                          (totalEntradas - totalSalidas).toDouble(),
                          Color.fromARGB(255, 92, 247, 144),
                        ),
                      ],
                      animationDuration: 0,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      dataLabelMapper: (datum, index) => datum.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total ingresos ${oCcy.format(totalEntradas).toString()}',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total gastos ${oCcy.format(totalSalidas).toString()}',
                    ),
                    const Icon(
                      Icons.amp_stories,
                      color: Color.fromARGB(255, 199, 199, 199),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Disponible ${oCcy.format(totalEntradas - totalSalidas).toString()}',
                    ),
                    const Icon(
                      Icons.amp_stories,
                      color: Color.fromARGB(255, 92, 247, 144),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, this.color);
}
