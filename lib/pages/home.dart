import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
    setState(() {
      fechaInicial = DateTime.now().subtract(Duration(days: 500000));
      controller.selectIndex(4);
    });
    super.initState();
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

    List<ChartData2> gastos2 = [];
    Map<String, double> gastos = {};

    for (Spent spe in salidas) {
      if (gastos.containsKey(spe.category)) {
        gastos[spe.category] = gastos[spe.category]! + spe.value.toDouble();
      } else {
        gastos[spe.category] = spe.value.toDouble();
      }
    }
    double maximoGastos = 0;
    gastos.forEach((key, value) {
      if (value > maximoGastos) {
        maximoGastos = value;
      }
      gastos2.add(ChartData2(key, value));
    });

    Map<String, double> ingresos = {};
    List<ChartData2> ingresos2 = [];

    for (Entry entr in entradas) {
      if (ingresos.containsKey(entr.category)) {
        ingresos[entr.category] =
            ingresos[entr.category]! + entr.value.toDouble();
      } else {
        ingresos[entr.category] = entr.value.toDouble();
      }
    }

    double maximoIngresos = 0;
    ingresos.forEach((key, value) {
      if (value > maximoIngresos) {
        maximoIngresos = value;
      }
      ingresos2.add(ChartData2(key, value));
    });

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerPropio(),
      floatingActionButton: SpeedDial(
        backgroundColor: Config.blue,
        icon: Icons.arrow_circle_up,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Config.blueOpaco,
            foregroundColor: Colors.white,
            label: 'Nuevo gasto',
            onTap: () {
              Navigator.pushNamed(context, 'new_spent');
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Config.blueOpaco,
            foregroundColor: Colors.white,
            label: 'Nuevo ingreso',
            onTap: () {
              Navigator.pushNamed(context, 'new_entry');
            },
          ),
        ],
      ),
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
                SizedBox(
                  height: 40,
                ),
                Text("Gastos"),
                gastos2.length > 0
                    ? SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: maximoGastos,
                            interval: maximoGastos / 4),
                        series: <ChartSeries<ChartData2, String>>[
                          ColumnSeries<ChartData2, String>(
                              dataSource: gastos2,
                              xValueMapper: (ChartData2 data, _) => data.x,
                              yValueMapper: (ChartData2 data, _) => data.y,
                              name: 'Gold',
                              color: Color.fromRGBO(8, 142, 255, 1))
                        ],
                      )
                    : Text(""),
                SizedBox(
                  height: 40,
                ),
                Text("Ingresos"),
                ingresos2.length > 0
                    ? SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: maximoIngresos,
                            interval: maximoIngresos / 4),
                        series: <ChartSeries<ChartData2, String>>[
                          ColumnSeries<ChartData2, String>(
                              dataSource: ingresos2,
                              xValueMapper: (ChartData2 data, _) => data.x,
                              yValueMapper: (ChartData2 data, _) => data.y,
                              name: 'Gold',
                              color: Color.fromRGBO(8, 142, 255, 1))
                        ],
                      )
                    : Text(""),
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

class ChartData2 {
  ChartData2(this.x, this.y);

  final String x;
  final double y;
}
