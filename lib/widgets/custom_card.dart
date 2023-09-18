import 'package:app_metricas/models/arguments.dart';
import 'package:flutter/material.dart';
import 'package:app_metricas/Theme/app_theme.dart';

class CustomCard extends StatelessWidget {
  final Arguments args;
  const CustomCard({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: AppTheme.primary.withOpacity(0.8),
      child: Column(
        children: [
          ListTile(
            title: Center(child: Text(args.name)),
            subtitle: Center(
              child: Column(
                children: [
                  Text('n1: ' + args.n1.toString()),
                  Text('n2: ' + args.n2.toString()),
                  Text('n: ' + args.n.toString()),
                  Text('N1: ' + args.nn1.toString()),
                  Text('N2: ' + args.nn2.toString()),
                  Text('N: ' + args.nn.toString()),
                  Text('V: ' + args.V.toString()),
                  Text('D: ' + args.D.toString()),
                  Text('L: ' + args.L.toString()),
                  Text('B' + args.E.toString()),
                  Text('T: ' + args.T.toString()),
                  Text('B: ' + args.B.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
