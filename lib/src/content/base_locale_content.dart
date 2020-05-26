import 'package:recase/recase.dart';

class BaseLocaleContent {
  final Map<String, int> keysWithId;

  BaseLocaleContent(this.keysWithId);

  String _classContent(String content) => """
abstract class S {
$content
String get(int id);
}
""";

  String _fieldContent(String name, int id) => "static const $name = $id;";

  String content() {
    return _classContent(
      keysWithId.entries
          .map((entity) => _fieldContent(entity.key.camelCase, entity.value))
          .join("\n"),
    );
  }
}
