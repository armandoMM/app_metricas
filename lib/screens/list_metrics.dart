import 'package:app_metricas/Providers/metrics_list_provider.dart';
import 'package:app_metricas/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:app_metricas/Providers/db_provider.dart';
import 'package:app_metricas/Theme/app_theme.dart';
import 'package:app_metricas/models/arguments.dart';
import 'package:app_metricas/widgets/custom_card.dart';
import 'package:provider/provider.dart';

class ListMetricsScreen extends StatefulWidget {
  const ListMetricsScreen({Key? key}) : super(key: key);

  @override
  State<ListMetricsScreen> createState() => _ListMetricsScreenState();
}

class _ListMetricsScreenState extends State<ListMetricsScreen> {
  // List<Arguments> totalArgs = [];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  Future fetchData() async {
    // print(isLoading);
    if (isLoading) return;
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;

    setState(() {});
    if (scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent) return;
    // scrollController.animateTo(scrollController.position.pixels + 120,
    //     duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final metricsProvider = Provider.of<MetricsListProvider>(context);
    final metrics = metricsProvider.totalArgs;
    List<Arguments> totalArgs = metricsProvider.totalArgs;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('LISTA DE MÉTRICAS'),
        ),
      ),
      body: Stack(
        children: [
          if (totalArgs.isEmpty)
            const Center(
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                      child: Text(
                    'NO SE ENCONTRARON MÉTRICAS',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
                  ))),
            ),
          if (totalArgs.isNotEmpty)
            RefreshIndicator(
              color: AppTheme.primary,
              onRefresh: onRefresh,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                itemCount: metrics.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomCard(args: metrics[index]);
                },
              ),
            ),
          if (isLoading)
            Positioned(bottom: 40, left: (size.width * 0.5 - 40), child: const _LoadingIcon()),
        ],
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      height: 60,
      width: 60,
      child: const CircularProgressIndicator(
        color: AppTheme.primary,
      ),
    );
  }
}
