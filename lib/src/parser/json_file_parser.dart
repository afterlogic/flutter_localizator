import 'dart:convert';
import 'dart:io';

import 'package:localizator/src/exception/parse_exception.dart';
import 'package:localizator/src/localizator/localization_filed.dart';
import 'package:localizator/src/util/file_util.dart';

import 'locale_map.dart';

class JsonFileParser {
  final decoder = JsonCodec();

  JsonFileParser();

  Map<String, dynamic> _parse(String textJson) {
    return decoder.decode(textJson.replaceAll("\\", "\\\\"));
  }

  Future<LocaleMap> createLocaleMap(File file) async {
    try {
      return LocaleMap(
        getFileLocale(file),
        LocalizationField.fromMap(_parse(await file.readAsString())),
      );
    } catch (e) {
      throw ParseException(file.path, e.toString());
    }
  }
}
