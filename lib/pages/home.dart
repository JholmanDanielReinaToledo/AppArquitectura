import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
              'Disponible ${entriesProvider.total - spendsProvider.total}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        children: <Widget>[
          SfCircularChart(
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
                    'Ingresos disponibles',
                    (entriesProvider.total - spendsProvider.total).toDouble(),
                    Color.fromARGB(255, 92, 247, 144),
                  ),
                ],
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              )
            ],
          ),
          Center(
            child: Text(
              'Total ingresos ${entriesProvider.total.toString()}',
            ),
          ),
          Center(
            child: Text(
              'Total gastos ${spendsProvider.total.toString()}',
            ),
          ),
          Center(
            child: Text(
              'Disponible ${entriesProvider.total - spendsProvider.total}',
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
