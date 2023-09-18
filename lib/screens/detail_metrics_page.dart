import 'package:app_metricas/Providers/db_provider.dart';
import 'package:app_metricas/Theme/app_theme.dart';
import 'package:app_metricas/models/arguments.dart';
import 'package:app_metricas/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:app_metricas/router/routes.dart';

class DetailMetricsScreen extends StatelessWidget {
  const DetailMetricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 150),
        children: [
          const Center(
            child: Text(
              'Métricas calculadas: ',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 35),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomCard(args: args)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.close),
          onPressed: () {
            DBProvider.db.newMetric(args);
            Navigator.pushNamed(context, AppRoutes.initialRoute);
          }),
    );
  }
}
