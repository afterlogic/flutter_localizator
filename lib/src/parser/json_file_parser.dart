import 'dart:convert';
import 'dart:io';

import 'package:localizator/src/localizator/localization_filed.dart';

import 'locale_map.dart';

class JsonFileParser {
  final decoder = JsonCodec();

  JsonFileParser();

  String getLocale(String fileName) {
    return fileName.split(".").first;
  }

  Map<String, dynamic> parse(String textJson) {
    return json.decode(textJson);
  }

  Future<LocaleMap> createLocaleMap(File file) async {
    final filename = file.path.split(Platform.pathSeparator).last;
    return LocaleMap(
      getLocale(filename),
      LocalizationField.fromMap(parse(await file.readAsString())),
    );
  }
}
