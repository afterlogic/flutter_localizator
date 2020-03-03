import 'package:dart_style/dart_style.dart';
import 'package:localizator/src/config.dart';
import 'package:localizator/src/locale/locale_map.dart';
import 'package:localizator/src/util/case_util.dart';

class LocaleContent {
  final LocaleMap localeMap;
  final Config config;

  LocaleContent(
    this.localeMap,
    this.config,
  );

  String build() {
    final path = "${config.inputPath}/${localeMap.fileName}";

    final out = _imports() + _classContent(localeMap.locale, path);
    return DartFormatter().format(out);
  }

  String toCode(dynamic value) {
    final code = value.toString();
    if (value is String) {
      return "\"$code\"";
    }
    return code;
  }

  String _imports() => """
  import 'dart:convert';
  import 's.dart';  
  import 'dart:ui';
  import 'package:flutter/services.dart';
      """;

  String _classContent(String localeCode, String path) => """ 
      class ${localeCode.firstToUpper}S extends S {
      final _path="$path";
      final Locale locale = Locale(\"$localeCode\");
      @override
      final Map<String, String> map;
      
      ${localeCode.firstToUpper}S._(this.map);
        
      Future<${localeCode.firstToUpper}S> load() async {
        final map = jsonDecode(await rootBundle.loadString(_path));
        return ${localeCode.firstToUpper}S._(map);
      }
      }
      """;
}
