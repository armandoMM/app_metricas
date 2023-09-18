import 'package:app_metricas/Providers/db_provider.dart';
import 'package:app_metricas/models/models.dart';
import 'package:flutter/material.dart';

class MetricsListProvider extends ChangeNotifier {
  List<Arguments> totalArgs = [];

  cargarMetricas() async {
    final args = await DBProvider.db.getAllMetrics();
    this.totalArgs = [...args];
    notifyListeners();
  }
}
