import 'dart:io';
import 'package:localizator/src/parser/json_file_parser.dart';
import 'package:localizator/src/parser/locale_map.dart';

import 'localizator/localization_maker.dart';

class Localization {
  final jsonParser = JsonFileParser();
  final localizationMaker = LocalizationMaker();
  final Directory directory;
  final String outPath;
  final String jsonPath;
  final String baseLocaleCode;

  Localization(
    this.directory,
    String outPath,
    String jsonPath,
    this.baseLocaleCode,
  )   : outPath = preparePath(outPath),
        jsonPath = preparePath(jsonPath);

  static String preparePath(String path) {
    return path.replaceAll(RegExp("\/|\\\\"), Platform.pathSeparator);
  }

  Future<List<LocaleMap>> _getInputJson() async {
    final path = directory.path + Platform.pathSeparator + jsonPath;
    final jsonDirectory = Directory(path);
    final jsonFile = File(path);

    if (await jsonDirectory.exists()) {
      final localeMap = await jsonDirectory.list().asyncMap((item) {
        return jsonParser.createLocaleMap(File(item.path));
      }).toList();
      return localeMap;
    } else if (await jsonFile.exists()) {
      return [await jsonParser.createLocaleMap(jsonFile)];
    }
    return [];
  }

  Future<void> _makeLocalization(List<LocaleMap> localeMap) async {
    final outDirectory =
        Directory(directory.path + Platform.pathSeparator + outPath);

    localizationMaker.createLocaleFiles(
      outDirectory,
      localeMap,
      baseLocaleCode,
    );
  }

  Future<void> build() async {
    final localeMaps = await _getInputJson();
    if (localeMaps.isEmpty) {
      return;
    }
    await _makeLocalization(localeMaps);
  }
}
