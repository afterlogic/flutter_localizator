import 'package:localizator/src/locale/locale_map.dart';

class BaseLocaleMap {
  final Map<String, bool> map;

  BaseLocaleMap(this.map);

  static BaseLocaleMap fromLocaleMaps(List<LocaleMap> localeMaps) {
    final exitString = <String>{};
    final indexWithParams = <String>{};
    for (var map in localeMaps) {
      for (var entity in map.map.entries) {
        exitString.add(entity.key);
      }
      indexWithParams.addAll(map.hasParams);
    }
    final iterable = exitString.map((key) {
      return MapEntry(key, indexWithParams.contains(key));
    });
    return BaseLocaleMap(Map.fromEntries(iterable));
  }
}

class LocalizationField {
  final bool hasParams;
  final String name;

  LocalizationField(this.hasParams, this.name);
}
