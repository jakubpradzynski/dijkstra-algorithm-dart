const int MAX = 1000000;

void calculate(Graph graph, Vertex startVertex) {
  var distances = <Vertex, int>{};
  var previous = <Vertex, Vertex>{};
  for (var vertex in graph.vertices) {
    distances[vertex] = MAX;
    previous[vertex] = null;
  }
  distances[startVertex] = 0;
  var Q = List<Vertex>.from(graph.vertices);
  print('START:\n');
  printDistances(distances, startVertex);
  printPrevious(previous, startVertex);
  printNotVisitedVertices(Q);
  var step = 0;
  while (Q.isNotEmpty) {
    Vertex vertex;
    var index = 0;
    var sortedVerticesByDistance = Map.fromEntries(distances.entries.toList()
          ..sort((e1, e2) => e1.value.compareTo(e2.value)))
        .keys
        .toList();
    while (!Q.contains(vertex)) {
      vertex = sortedVerticesByDistance[index];
      index++;
    }
    Q = Q..remove(vertex);
    for (var edge in vertex.edges) {
      var neighbor = Q.firstWhere((v) => v.name == edge.to, orElse: () => null);
      if (neighbor != null) {
        var newDistance = distances[vertex] + edge.weight;
        if (newDistance < distances[neighbor]) {
          distances[neighbor] = newDistance;
          previous[neighbor] = vertex;
        }
      }
    }
    step++;
    print('STEP $step:\n');
    printDistances(distances, startVertex);
    printPrevious(previous, startVertex);
    printNotVisitedVertices(Q);
  }
  print('END\n');
  printDistances(distances, startVertex);
  printPrevious(previous, startVertex);
}

void printDistances(Map<Vertex, int> distances, Vertex startVertex) {
  print('Distances from start vertex:');
  print(distances.entries
      .map((entry) {
        if (entry.key != startVertex) {
          return '${startVertex}--${entry.value == MAX ? "X" : entry.value}-->${entry.key.name}';
        }
        return null;
      })
      .where((t) => t != null)
      .join(', '));
  print('');
}

void printPrevious(Map<Vertex, Vertex> previous, Vertex startVertex) {
  print('Previous vertex:');
  print(previous.entries
      .map((entry) {
        if (entry.key != startVertex) {
          return '${entry.value ?? "X"}-->${entry.key}';
        }
        return null;
      })
      .where((t) => t != null)
      .join(', '));
  print('');
}

void printNotVisitedVertices(List<Vertex> vertices) {
  print('Not visited vertices:');
  print(vertices.map((v) => v.name).join(', '));
  print('');
}

class Graph {
  List<Vertex> vertices;
  Graph(List<Vertex> vertices) {
    this.vertices = vertices;
  }

  @override
  String toString() {
    if (vertices == null) return '';
    return vertices.map((v) => v.toString()).join('\n');
  }
}

class Vertex {
  String name;
  List<Edge> edges;
  Vertex(String name, List<Edge> edges) {
    this.name = name;
    this.edges = edges;
  }

  @override
  String toString() {
    if (edges == null) return '$name';
    return '$name';
  }
}

class Edge {
  String from, to;
  int weight;
  Edge(String from, String to, int weight) {
    this.from = from;
    this.to = to;
    this.weight = weight;
  }

  @override
  String toString() {
    return '{from: $from, to: $to, weight: $weight}';
  }
}
