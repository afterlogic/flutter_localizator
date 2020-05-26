import "s.dart";

class EnS extends S {
  final _map = <int, String>{
    0: "test",
    1: "text",
    2: "text %s\n\"",
  };
  String get(int id) => _map[id];
}
