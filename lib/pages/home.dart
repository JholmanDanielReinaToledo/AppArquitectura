import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final oCcy = NumberFormat("\$#,##0", "en_US");

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService2>(context);
    // print(authService.user.displayName);

    final entriesProvider = Provider.of<EntryListProvider>(context);
    final spendsProvider = Provider.of<SpentListProvider>(context);

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
              'Disponible ${oCcy.format(entriesProvider.total - spendsProvider.total)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        children: <Widget>[
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
                    spendsProvider.total.toDouble(),
                    Color.fromARGB(19, 199, 199, 199),
                  ),
                  ChartData(
                    'Disponible',
                    (entriesProvider.total - spendsProvider.total).toDouble(),
                    Color.fromARGB(255, 92, 247, 144),
                  ),
                ],
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
                'Total ingresos ${oCcy.format(entriesProvider.total).toString()}',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total gastos ${oCcy.format(spendsProvider.total).toString()}',
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
                'Disponible ${oCcy.format(entriesProvider.total - spendsProvider.total).toString()}',
              ),
              const Icon(
                Icons.amp_stories,
                color: Color.fromARGB(255, 92, 247, 144),
              ),
            ],
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
