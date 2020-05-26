library localizator;

export 'src/model/config.dart';
import 'dart:io';

import 'package:localizator/src/localizator_generator.dart';
import 'package:localizator/src/model/config.dart';
import 'package:localizator/src/util/file_util.dart';

localizator(Config config) async {
  final dir = Directory.current;
  Directory inputDirectory = Directory(
      preparePath(dir.path + Platform.pathSeparator + config.inputPath));
  Directory outputDirectory = Directory(
      preparePath(dir.path + Platform.pathSeparator + config.outputPath));
  LocalizatorGenerator(inputDirectory,outputDirectory, config).generate();
}
