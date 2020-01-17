import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:localizator/src/parser/locale_map.dart';

import 'localization_filed.dart';

class LocalizationMaker {
  final dartFormatted = DartFormatter();

  LocalizationMaker();

  String _build(LocaleMap localeMap, LocaleMap baseLocaleMap) {
    final isSuper = baseLocaleMap == localeMap;

    var outText = "";
    outText += "import 'dart:ui';";
    if (!isSuper) {
      outText += "import '${baseLocaleMap.fileName}.dart';";
      outText +=
          "class ${localeMap.className} extends ${baseLocaleMap.className} {\n";
    } else {
      outText += "abstract class ${localeMap.className} {\n";
    }
    if (isSuper) {
      outText += "Locale get locale;";
    } else {
      outText += "final Locale locale=Locale(\"${localeMap.localeCode}\");";
    }

    localeMap.field.forEach((item) {
      final field = _makeField(item, isSuper);
      if (field != null) {
        outText += field + "\n";
      }
    });
    outText += "}";
    return dartFormatted.format(outText);
  }

  String _makeField(LocalizationField field, bool isSuper) {
    var textEnvironment = field.environment.toString();
    textEnvironment = textEnvironment.substring(1, textEnvironment.length - 1);

    final isFunction = field.environment.isNotEmpty;

    final fieldName =
        isFunction ? "${field.name}(String $textEnvironment)":field.name ;

    final fieldWithType = isFunction
        ? "String $fieldName"
        : isSuper ? "String get $fieldName" : "final String $fieldName";
    final filedValue = isSuper
        ? ";"
        : isFunction ? "=>\"${field.value}\";" : "=\"${field.value}\";";

    return fieldWithType + filedValue;
  }

  Future<void> createLocaleFiles(
    Directory directory,
    List<LocaleMap> localeMaps,
    String baseLocaleCode,
  ) async {
    final baseLocaleMap = localeMaps
        .firstWhere(
          (item) => item.localeCode == baseLocaleCode,
          orElse: () => localeMaps.first,
        )
        .toSuper(superClass);

    createLocaleFile(directory, baseLocaleMap, baseLocaleMap);

    for (var localeMap in localeMaps) {
      createLocaleFile(directory, localeMap, baseLocaleMap);
    }
  }

  Future<void> createLocaleFile(
    Directory directory,
    LocaleMap value,
    LocaleMap baseLocaleMap,
  ) async {
    final outFile = File(
      directory.path + Platform.pathSeparator + value.fileName + ".dart",
    );
    await outFile.create();

    final content = _build(value, baseLocaleMap);
    outFile.writeAsString(content);
  }

  static const superClass = "s";
}
