library localizator;

import 'dart:io';

import 'src/localization.dart';

localize(String jsonPath, String outPath, String baseLocale) async {
  await Localization(
    Directory.current,
    outPath,
    jsonPath,
    baseLocale,
  ).build();
}
