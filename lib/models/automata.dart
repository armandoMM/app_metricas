class Automata {
  final String nombre;
  final letras = "abcedfghijklmnñopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final espacio = " ";
  final salidas = "\n\t";
  final operadoresS = "+-*/:=><,";
  final numeros = "1234567890";
  final comentarios = '#';
  int def = 0;
  int iF = 0;
  int While = 0;
  int parentesis = 0;
  int suma = 0;
  int resta = 0;
  int division = 0;
  int multiplicacion = 0;
  int igual = 0;
  int mayor = 0;
  int menor = 0;
  int coma = 0;
  int dosP = 0;
  int comments = 0;
  int prints = 0;
  List<String> tokens = [];
  List<String> variablesVec = [];
  List<double> variablesNum = [];

  final automataPrint = {
    ["q0", "p", "q1"],
    ["q1", "r", "q2"],
    ["q2", "i", "q3"],
    ["q3", "n", "q4"],
    ["q4", "t", "q5"],
    ["q5", "espacio", "qf"],
  }; //regresa 1

  final automataDef = {
    ["q0", "d", "q1"],
    ["q1", "e", "q2"],
    ["q2", "f", "q3"],
    ["q3", "espacio", "qf"],
  };

  final automataReturn = {
    ["q0", "r", "q1"],
    ["q1", "e", "q2"],
    ["q2", "t", "q3"],
    ["q3", "u", "q4"],
    ["q4", "r", "q5"],
    ["q5", "n", "q6"],
    ["q6", "espacio", "qf"],
  }; //regresa 1

  final automataIf = {
    ["q0", "i", "q1"],
    ["q1", "f", "q2"],
    ["q2", "espacio", "qf"],
    ["q2", "(", "qf"],
  }; //regresa 1

  final automataWhile = {
    ["q0", "w", "q1"],
    ["q1", "h", "q2"],
    ["q2", "i", "q3"],
    ["q3", "l", "q4"],
    ["q4", "e", "q5"],
    ["q5", "espacio", "qf"],
    ["q5", "(", "qf"],
  }; //regresa 1

  /*final nombreFuncion = {
            {"q0","letras","q1"},
            {"q1","letras","q1"},
            {"q1","numeros","q1"},
            {"q1","espacio","qf"},
            {"q1","(","qf"},
    };//regresa 1*/

  final parentesisFuncion = {
    ["q0", "(", "qf"],
    ["q0", ")", "qf"],
  };
  //no regresa

  final automataComentario = {
    ["q0", "#", "q1"],
    ["q1", "espacio", "q1"],
    ["q1", "letras", "q1"],
    ["q1", "numeros", "q1"],
    ["q1", "operadores", "q1"],
    ["q1", "(", "q1"],
    ["q1", ")", "q1"],
    ["q1", "salidas", "qf"],
  };

  final variables = {
    ["q0", "letras", "q1"],
    ["q1", "letras", "q1"],
    ["q1", "numeros", "q1"],
    ["q1", "salidas", "qf"],
    ["q1", "espacio", "qf"],
    ["q1", "operadores", "qf"],
    ["q1", "(", "qf"],
    ["q1", ")", "qf"],
  }; //regresa 1

  final operNumeros = {
    ["q0", "numeros", "q1"],
    ["q1", "numeros", "q1"],
    ["q1", "salidas", "qf"],
    ["q1", "espacio", "qf"],
    ["q1", "operadores", "qf"],
    ["q1", "(", "qf"],
    ["q1", ")", "qf"],
  }; //regresa 1

  final operadores = {
    ["q0", "operadores", "qf"]
  }; //no regresa

  final ignore = {
    ["q0", "salidas", "qf"],
    ["q0", "espacio", "qf"],
  }; //no regresa

  Automata(
    this.nombre,
  );

  bool contiene(String cad, String tipo) {
    if (tipo.compareTo("letras") == 0) {
      if (letras.contains(cad)) return true;
    } else if (tipo.compareTo("salidas") == 0) {
      if (salidas.contains(cad)) return true;
    } else if (tipo.compareTo("operadores") == 0) {
      if (operadoresS.contains(cad)) return true;
    } else if (tipo.compareTo("comentario") == 0) {
      if (comentarios.contains(cad)) return true;
    } else if (tipo.compareTo("d") == 0) {
      if ("d".contains(cad)) return true;
    } else if (tipo.compareTo("e") == 0) {
      if ("e".contains(cad)) return true;
    } else if (tipo.compareTo("f") == 0) {
      if ("f".contains(cad)) return true;
    } else if (tipo.compareTo("espacio") == 0) {
      if (espacio.contains(cad)) return true;
    } else if (tipo.compareTo("(") == 0) {
      if ("(".contains(cad)) return true;
    } else if (tipo.compareTo(")") == 0) {
      if (")".contains(cad)) return true;
    } else if (tipo.compareTo("numeros") == 0) {
      if (numeros.contains(cad)) return true;
    } else if (tipo.compareTo("i") == 0) {
      if ("i".contains(cad)) return true;
    } else if (tipo.compareTo("f") == 0) {
      if ("f".contains(cad)) return true;
    } else if (tipo.compareTo("w") == 0) {
      if ("w".contains(cad)) return true;
    } else if (tipo.compareTo("h") == 0) {
      if ("h".contains(cad)) return true;
    } else if (tipo.compareTo("l") == 0) {
      if ("l".contains(cad)) return true;
    } else if (tipo.compareTo("r") == 0) {
      if ("r".contains(cad)) return true;
    } else if (tipo.compareTo("t") == 0) {
      if ("t".contains(cad)) return true;
    } else if (tipo.compareTo("u") == 0) {
      if ("u".contains(cad)) return true;
    } else if (tipo.compareTo("n") == 0) {
      if ("n".contains(cad)) return true;
    } else if (tipo.compareTo("#") == 0) {
      if ("#".contains(cad)) return true;
    } else if (tipo.compareTo("print") == 0) {
      if ("print".contains(cad)) return true;
    }

    return false;
  }

  Set<List<String>> tipoAutomata(String tipo) {
    if (tipo == "def") {
      return automataDef;
    } else if (tipo == "automataIf") {
      return automataIf;
    } else if (tipo == "automataWhile") {
      return automataWhile;
    } else if (tipo == "operNumeros") {
      return operNumeros;
    } else if (tipo == "parentesis") {
      return parentesisFuncion;
    } else if (tipo == "variables") {
      return variables;
    } else if (tipo == "operadores") {
      return operadores;
    } else if (tipo == "ignore") {
      return ignore;
    } else if (tipo == "automataReturn") {
      return automataReturn;
    } else if (tipo == "automataComentario") {
      return automataComentario;
    } else if (tipo == "automataPrint") {
      return automataPrint;
    }

    return {};
  }

  int valueAutomata(String codigo, int apuntado, String automataTipo) {
    int j = apuntado; //recorre el codigo
    int indiceEstado = 0; //recorre los estados del automata
    String estadoActual = "q0"; //estado actual
    Set<List<String>> automata = tipoAutomata(automataTipo); //trae automata a utilizar
    if (automata.isEmpty) {
      return 0;
    }
    while (indiceEstado < automata.length && j < codigo.length) {
      String estadoAutomata = automata.elementAt(indiceEstado).elementAt(0);
      if (estadoActual.compareTo("qf") == 0) {
        if (automataTipo.compareTo("operadores") == 0 ||
            automataTipo.compareTo("ignore") == 0 ||
            automataTipo.compareTo("parentesis") == 0) {
          return j;
        }
        return j - 1;
      } else {
        if (estadoActual == estadoAutomata) {
          if (contiene(codigo[j], automata.elementAt(indiceEstado).elementAt(1))) {
            estadoActual = automata.elementAt(indiceEstado).elementAt(2);
            indiceEstado = 0; //0
            j++;
          } else {
            indiceEstado++;
          }
        } else {
          indiceEstado++;
        }
      }
    }

    if (estadoActual.compareTo("qf") == 0) {
      if (automataTipo.compareTo("operadores") == 0 ||
          automataTipo.compareTo("ignore") == 0 ||
          automataTipo.compareTo("parentesis") == 0) {
        return j;
      }
      return j - 1;
    }

    return 0;
  }

  String initMetricas(String codigo) {
    int apuntador = 0;
    int topeAnt;
    String token;
    const automatas = {
      "automataComentario",
      "def",
      "automataReturn",
      "automataIf",
      "automataWhile",
      "variables",
      "operNumeros",
      "parentesis",
      "operadores",
      "automataPrint",
      "ignore"
    };

    while (apuntador < codigo.length) {
      int j = 0; //indice que recorre los automatas
      int topeAux;
      while (j < automatas.length) {
        topeAux = valueAutomata(codigo, apuntador, automatas.elementAt(j));
        if (topeAux > 0) {
          topeAnt = apuntador;
          apuntador = topeAux;
          token = codigo.substring(topeAnt, apuntador);
          tokens.add(token);

          if (automatas.elementAt(j).compareTo("automataComentario") == 0 ||
              token.compareTo("#") == 0) {
            comments++;
          } else if (automatas.elementAt(j).compareTo("def") == 0 || token.compareTo("def") == 0) {
            def++;
          } else if (automatas.elementAt(j).compareTo("automataPrint") == 0 ||
              token.compareTo("print") == 0) {
            prints++;
          } else if (automatas.elementAt(j).compareTo("automataIf") == 0 ||
              token.compareTo("if") == 0) {
            iF++;
          } else if (automatas.elementAt(j).compareTo("parentesis") == 0 ||
              token.compareTo("(") == 0 ||
              token.compareTo(")") == 0) {
            parentesis++;
          } else if (automatas.elementAt(j).compareTo("operadores") == 0) {
            switch (token) {
              case "+":
                suma++;
                break;
              case "-":
                resta++;
                break;
              case "/":
                division++;
                break;
              case "*":
                multiplicacion++;
                break;
              case "=":
                igual++;
                break;
              case ">":
                mayor++;
                break;
              case "<":
                menor++;
                break;
              case ",":
                coma++;
                break;
              case ":":
                dosP++;
                break;
            }
          } else if (automatas.elementAt(j).compareTo("variables") == 0 ||
              automatas.elementAt(j).compareTo("operNumeros") == 0) {
            if (!variablesVec.contains(token)) {
              variablesVec.add(token);
              variablesNum.add(1);
            } else {
              for (int i = 0; i < variablesVec.length; i++) {
                if (variablesVec.elementAt(i).compareTo(token) == 0) {
                  double val = variablesNum.elementAt(i);
                  val = val + 1;
                  variablesNum[i] = val;
                }
              }
            }
          }
          break;
        } else {
          j++;
        }
      }
      if (j == automatas.length) {
        return '';
      }
    }
    return variablesNum.elementAt(0).toString();
  }

  int getDef() {
    return def;
  }

  int getiF() {
    return iF;
  }

  int getWhile() {
    return While;
  }

  int getParentesis() {
    return parentesis;
  }

  int getSuma() {
    return suma;
  }

  int getResta() {
    return resta;
  }

  int getDivision() {
    return division;
  }

  int getMultiplicacion() {
    return multiplicacion;
  }

  int getIgual() {
    return igual;
  }

  int getMayor() {
    return mayor;
  }

  int getMenor() {
    return menor;
  }

  int getComa() {
    return coma;
  }

  int getDosP() {
    return dosP;
  }

  int getCommments() {
    return comments;
  }

  int getPrints() {
    return prints;
  }

  List<double> getVariablesNum() {
    return variablesNum;
  }

  List<String> getVariablesVec() {
    return variablesVec;
  }
}
