import 'dart:convert';
import 'dart:io';

import 'package:localizator/src/config.dart';
import 'package:localizator/src/util/file_util.dart';

class LocaleMap {
  final String locale;
  final Map<String, String> map;
  final Set<String> hasParams;
  final String fileName;

  LocaleMap(this.locale, this.map, this.hasParams, this.fileName);

  static LocaleMap fromFile(Config config, File file) {
    assert(file.existsSync());
    final fileName = getFileName(file);
    final localeCode = RegExp(config.localeMask).firstMatch(fileName)?.group(1);
    final hasParams = <String>{};
    final dynamicMap =
        json.decode(file.readAsStringSync()) as Map<String, dynamic>;
    final map = dynamicMap.map((key, value) {
      final textValue = value.toString();
      if (textValue.contains("%s")) {
        hasParams.add(key);
      }
      return MapEntry(key, textValue);
    });

    return LocaleMap(localeCode, map, hasParams, fileName);
  }
}
