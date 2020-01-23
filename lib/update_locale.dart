import 'dart:io';

import 'package:localizator/src/update_locale.dart';

updateLocale(String from, String baseLocale) async {
  try {
    await UpdateLocale(
      Directory.current,
      from,
      baseLocale,
    ).build();
  } catch (e) {
    print(e);
  }
}
