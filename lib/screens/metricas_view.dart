import 'package:app_metricas/models/arguments.dart';
import 'package:flutter/material.dart';
import 'package:app_metricas/models/automata.dart';
import 'package:app_metricas/Theme/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:app_metricas/router/routes.dart';
import 'dart:io';
import 'dart:math';

class MetricasViewScreen extends StatefulWidget {
  const MetricasViewScreen({Key? key}) : super(key: key);

  @override
  State<MetricasViewScreen> createState() => _MetricasViewScreenState();
}

class _MetricasViewScreenState extends State<MetricasViewScreen> {
  final menuOptions = AppRoutes.menuOptions;
  FilePickerResult? result;
  String? name;
  PlatformFile? filePicked;
  File? fileToDisplay;
  bool isLoading = false;
  int n1 = 0, n2 = 0, nn1 = 0, nn2 = 0, nn = 0, n = 0;
  double V = 0.0, D = 0.0, L = 0.0, E = 0.0, T = 0.0, B = 0.0;

  int nomOperadores(Automata automata) {
    int n = 0;

    if (automata.getSuma() > 0) n++;
    if (automata.getResta() > 0) n++;
    if (automata.getParentesis() > 0) n++;
    if (automata.getMultiplicacion() > 0) n++;
    if (automata.getMenor() > 0) n++;
    if (automata.getMayor() > 0) n++;
    if (automata.getIgual() > 0) n++;
    if (automata.getiF() > 0) n++;
    if (automata.getWhile() > 0) n++;
    if (automata.getDosP() > 0) n++;
    if (automata.getDivision() > 0) n++;
    if (automata.getDef() > 0) n++;
    if (automata.getComa() > 0) n++;
    if (automata.getCommments() > 0) n++;

    return n;
  }

  int totalOperadores(Automata automata) {
    double n = automata.getSuma() +
        automata.getResta() +
        (automata.getParentesis() / 2) +
        automata.getMultiplicacion() +
        automata.getMenor() +
        automata.getMayor() +
        automata.getIgual() +
        automata.getiF() +
        automata.getWhile() +
        automata.getDosP() +
        automata.getDivision() +
        automata.getDef() +
        automata.getComa() +
        automata.getCommments();
    // print('Total operadores: $n');
    return n.toInt();
  }

  int nomOperandos(Automata automata) {
    List<String> operandos = automata.getVariablesVec();
    int n = operandos.length;
    return n;
  }

  int totalOperandos(Automata automata) {
    double n = 0.0;
    List<double> operandos = automata.getVariablesNum();
    for (int i = 0; i < operandos.length; i++) {
      n = n + operandos.elementAt(i);
    }

    return n.toInt();
  }

  void basicMetrics(Automata automata, String name) {
    // numero de operadores
    n1 = nomOperadores(automata);
    //numero total de operadores
    nn1 = totalOperadores(automata);
    //numero de operandos
    n2 = nomOperandos(automata);
    //numero total de operandos
    nn2 = totalOperandos(automata);
    //longitud del programa
    nn = nn1 + nn2;
    //Vocabulario de P
    n = n1 + n2;
    //Volumen
    V = nn * (log(n) / log(2));
    //Dificultad
    D = (n1 / 2) * (nn2 / (n2));
    //Nivel
    L = 1 / D;
    //Esfuerzo
    E = D * V;
    //Tiempo
    T = E / 18;
    //Bugs
    B = pow(T, 2 / 3) / 3000;
  }

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result =
          await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['py']);
      if (result != null) {
        name = result!.files.first.name;
        filePicked = result!.files.first;
        fileToDisplay = File(filePicked!.path.toString());
        setState(() {});
        Automata automata = Automata(name!);
        String content = await fileToDisplay!.readAsString();
        List<String> code = content.split('\n');
        for (String c in code) {
          String a = automata.initMetricas(c);
        }
        int d = automata.getParentesis();
        basicMetrics(automata, name!);
        setState(() {});
        Navigator.pushNamed(context, menuOptions[1].route,
            arguments: Arguments(
                n1: n1,
                n2: n2,
                nn1: nn1,
                nn2: nn2,
                n: n,
                nn: nn,
                V: V,
                D: D,
                L: L,
                E: E,
                T: T,
                B: B,
                name: name!));
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: sizeH / 2 - 50,
            ),
            const Text(
              'Escoge un archivo: ',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: const SizedBox(width: 300, child: Center(child: Text('Abrir archivo'))),
                onPressed: () {
                  pickFile();
                }),
            const SizedBox(
              height: 30,
            ),
            Text(
              name != null ? '$name' : '',
              style: const TextStyle(color: AppTheme.primary, fontSize: 18),
            ),
            if (filePicked != null && isLoading)
              const Text(
                'Analizando',
                style: TextStyle(color: AppTheme.primary, fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
