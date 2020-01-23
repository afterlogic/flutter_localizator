library localizator;

import 'dart:io';

import 'src/localization.dart';

localize(String jsonPath, String outPath, String baseLocale) async {
  try {
    await Localization(
      Directory.current,
      outPath,
      jsonPath,
      baseLocale,
    ).build();
  } catch (e) {
    print(e);
  }
}
