import 'package:dijkstra_algorithm_dart/dijkstra_algorithm.dart' as dijkstra_algorithm;

import 'package:args/args.dart';
import 'dart:io';


void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('graphPath', abbr: 'g')
    ..addOption('startVertex', abbr: 'v');

  var results = parser.parse(arguments);
  var graph = loadGraph(results['graphPath']);

  dijkstra_algorithm.calculate(graph, graph.vertices.firstWhere((v) => v.name == results['startVertex']));
}

dijkstra_algorithm.Graph loadGraph(String graphPath) {
  var lines = File(graphPath).readAsLinesSync();
  var vericesNames = lines.first.replaceFirst('VERTICES ', '').split(',');
  var edges = lines.skip(1).map((line) {
    var parts = line.replaceFirst('EDGE ', '').split(',');
    return dijkstra_algorithm.Edge(parts[0], parts[1], int.parse(parts[2]));
  }).toList();
  return dijkstra_algorithm.Graph(vericesNames.map((name) {
    return dijkstra_algorithm.Vertex(name, edges.where((edge) => edge.from == name).toList());
  }).toList());
}