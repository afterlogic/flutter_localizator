import 'dart:convert';

import 'package:localizator/src/model/locale_map.dart';
import 'package:localizator/src/util/case_util.dart';

class LocaleContent {
  final LocaleMap localeMap;
  final Map<String, int> keysWithId;

  LocaleContent(this.keysWithId, this.localeMap);

  String _classContent(String content) => """
  import "s.dart";
  
class ${localeMap.locale.firstToUpper}S extends S{
final _map=<int,String>{
$content
};
String get(int id)=>_map[id];
}
""";

  String _prepareValue(String value) => _removeList(jsonEncode(value));

  String _removeList(String string) => string.substring(1, string.length - 1);

  String _entityContent(String id, String value) =>
      "$id : \"${_prepareValue(value)}\",";

  String content() {
    return _classContent(
      localeMap.map.entries
          .map((entity) => _entityContent("S.${entity.key}", entity.value))
          .join("\n"),
    );
  }
}
