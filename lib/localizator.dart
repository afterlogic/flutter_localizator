library localizator;

import 'dart:io';

import 'package:localizator/src/config.dart';
import 'package:localizator/src/content/base_locale_content.dart';
import 'package:localizator/src/content/locale_content.dart';
import 'package:localizator/src/locale/base_locale_map.dart';
import 'package:localizator/src/locale/locale_map.dart';

localizator(String inputPath, String outPath) async {
  final dir = Directory.current;

  final outputPath =
      dir.path + Platform.pathSeparator + outPath + Platform.pathSeparator;
  final config = Config("(\\w*).json", inputPath);

  final inputDir = Directory(dir.path + Platform.pathSeparator + inputPath);
  final entities = await inputDir.list().toList();
  final files = <File>[];
  for (var entity in entities) {
    if (entity.existsSync() &&
        entity.statSync().type == FileSystemEntityType.file) {
      files.add(File(entity.path));
    }
  }

  final localeMaps =
      files.map((file) => LocaleMap.fromFile(config, file)).toList();
  final baseLocaleMap = BaseLocaleMap.fromLocaleMaps(localeMaps);

  for (var localeMap in localeMaps) {
    final file = File(outputPath + localeMap.locale + ".dart");
    file.createSync(recursive: true);
    file.writeAsStringSync(LocaleContent(localeMap, config).build());
  }

  final file = File(outputPath + "s.dart");
  file.createSync(recursive: true);
  file.writeAsStringSync(BaseLocaleContent(baseLocaleMap).build());
}
