import 'package:app_metricas/Providers/metrics_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_metricas/Theme/app_theme.dart';
import 'package:app_metricas/router/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MetricsListProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Metricas de Healsted',
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.getAppRoutes(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: AppTheme.ligthTheme,
      ),
    );
  }
}
