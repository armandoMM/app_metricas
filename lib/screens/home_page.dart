import 'package:app_metricas/Providers/metrics_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_metricas/Theme/app_theme.dart';
import 'package:app_metricas/router/routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.menuOptions;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          const Center(
            child: Text(
              'Métricas de Healsted',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 38),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  child:
                      const SizedBox(width: 300, child: Center(child: Text('Calcular Métricas'))),
                  onPressed: () {
                    Navigator.pushNamed(context, menuOptions[0].route);
                  }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ElevatedButton(
                  child: const SizedBox(
                      width: 300, child: Center(child: Text('Historial de Metricas'))),
                  onPressed: () {
                    final metricsProvider =
                        Provider.of<MetricsListProvider>(context, listen: false);
                    metricsProvider.cargarMetricas();
                    Navigator.pushNamed(context, menuOptions[2].route);
                  }),
            ),
          ),
          const SizedBox(
            height: 250,
          ),
          const Center(
            child: Text(
              'Pablo Elias Colín Velázquez',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
            ),
          ),
          const Center(
            child: Text(
              'Armando Matias Montaño',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
            ),
          ),
          const Center(
            child: Text(
              '',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
