import 'package:dart_style/dart_style.dart';
import 'package:localizator/src/locale/base_locale_map.dart';

class BaseLocaleContent {
  final BaseLocaleMap _baseLocaleMap;

  BaseLocaleContent(this._baseLocaleMap);

  String build() {
    var functions = "";
    var stringRes = "";

    _baseLocaleMap.map.forEach((key, hasParams) {
      if (!hasParams) {
        functions += "String get $key => _string(id.$key);\n";
      } else {
        functions += "String $key(List<String> arg) => _string(id.$key,arg);\n";
      }
      stringRes += "String get $key=> \"$key\";\n";
    });

    return DartFormatter().format(
        _imports() + _sContent(functions) + _stringIdContent(stringRes));
  }

  String _imports() => """
  import 'dart:ui';
  import 'package:meta/meta.dart';
  //// ignore_for_file: non_constant_identifier_names
  """;

  String _sContent(String functions) => """
  abstract class S {
  Locale get locale;
  
  $functions
  
  Future load();
  
   String _string(String id, [List<String> arg]) {
    var string = map[id];
    if (arg == null) {
      return string;
    }
    return format(string, arg);
  }

  static format(String string, List<String> arg) {
    var text = string;
    if (text.contains("%")) {
      if (arg != null) {
        final reversed = RegExp("%s").allMatches(text).toList().reversed;
        if (reversed.length == arg.length) {
          var index = arg.length;
          for (var math in reversed) {
            index--;
            text = text.replaceRange(
              math.start,
              math.end,
              arg[index],
            );
          }
        }
      }
      final reversed = RegExp("%%*").allMatches(text)
          .toList()
          .reversed;
      for (var math in reversed) {
        final group = math.group(0);
        text = text.replaceRange(
          math.start,
          math.end,
          group.substring(1),
        );
      }
    }
    return text;
  }
  
  @protected
  Map<String, String> get map;

  static const id = _StringId();
  }
  """;

  String _stringIdContent(String stringRes) => """
  class _StringId {
  const _StringId();
  $stringRes
  }
  """;
}
