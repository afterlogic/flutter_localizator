import 'dart:convert';
import 'dart:io';
import 'package:dart_style/dart_style.dart';
import 'package:localizator/src/content/base_locale_content.dart';
import 'package:localizator/src/content/locale_content.dart';
import 'package:localizator/src/model/locale_map.dart';
import 'package:localizator/src/util/file_util.dart';

import 'model/config.dart';

class LocalizatorGenerator {
  final Config config;
  final Directory inputDirectory;
  final Directory outputDirectory;
  final DartFormatter dartFormatter = DartFormatter();

  LocalizatorGenerator(
    this.inputDirectory,
    this.outputDirectory,
    this.config,
  );

  Future<List<File>> _getInputFile() async {
    final entities = await inputDirectory.list().toList();
    final files = <File>[];
    for (var entity in entities) {
      final file = File(entity.path);
      if (RegExp(config.fileMask).hasMatch(getFileName(file))) {
        files.add(File(file.path));
      }
    }
    return files;
  }

  Future<Iterable<LocaleMap>> _fileToMap(List<File> files) async {
    return files.map(
      (file) {
        return LocaleMap(
          jsonDecode(file.readAsStringSync()),
          RegExp(config.fileMask).firstMatch(getFileName(file))?.group(1) ?? '',
        );
      },
    );
  }

  Set<String> _getAllKeys(Iterable<LocaleMap> localeMaps) {
    final set = <String>{};
    for (var locale in localeMaps) {
      for (var key in locale.map.keys) {
        if (key is String) set.add(key);
      }
    }
    return set;
  }

  Future _createFileWithContent(String name, String content) async {
    final file =
        File(outputDirectory.path + Platform.pathSeparator + name + ".dart");
    await file.create(recursive: true);
    await file.writeAsString(dartFormatter.format(content));
  }

  generate() async {
    final files = await _getInputFile();
    final localeMaps = await _fileToMap(files);
    final keys = _getAllKeys(localeMaps);
    final keysWithId =
        keys.toList().asMap().map((key, value) => MapEntry(value, key));
    await _createFileWithContent("s", BaseLocaleContent(keysWithId).content());
    for (var locale in localeMaps) {
      await _createFileWithContent(
          "${locale.locale}_s", LocaleContent(keysWithId, locale).content());
    }
  }
}
