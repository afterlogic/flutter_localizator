import "s.dart";

class EnS extends S {
  final _map = <int, String>{
    S.test: "test",
    S.text: "text",
    S.text_with_params: "text %s\n\"",
  };
  String get(int id) => _map[id];
}
