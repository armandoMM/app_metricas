import 'dart:convert';

Arguments argumentsFromJson(String str) => Arguments.fromJson(json.decode(str));

String argumentsToJson(Arguments data) => json.encode(data.toJson());

class Arguments {
  Arguments(
      {required this.n1,
      required this.n2,
      required this.nn1,
      required this.nn2,
      required this.n,
      required this.nn,
      required this.V,
      required this.D,
      required this.L,
      required this.E,
      required this.T,
      required this.B,
      required this.name});

  final int n1, n2, nn1, nn2, n, nn;
  final double V, D, L, E, T, B;
  final String name;

  factory Arguments.fromJson(Map<String, dynamic> json) => Arguments(
        n1: json["n1"],
        n2: json["n2"],
        nn1: json["nn1"],
        nn2: json["nn2"],
        n: json["n"],
        nn: json["nn"],
        V: json["V"].toDouble(),
        D: json["D"].toDouble(),
        L: json["L"].toDouble(),
        E: json["E"].toDouble(),
        T: json["T"].toDouble(),
        B: json["B"].toDouble(),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "n1": n1,
        "n2": n1,
        "nn1": nn1,
        "nn2": nn2,
        "n": n,
        "nn": nn,
        "V": V,
        "D": D,
        "L": L,
        "E": E,
        "T": T,
        "B": B,
        "name": name,
      };
}
