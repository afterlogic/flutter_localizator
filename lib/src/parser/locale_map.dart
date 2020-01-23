import 'package:localizator/src/localizator/localization_filed.dart';

class LocaleMap {
  final String localeCode;
  final List<LocalizationField> field;
  final bool _useSuffix;

  LocaleMap(this.localeCode, this.field, [this._useSuffix = true]);

  String get fileName => localeCode + (_useSuffix ? "_" + _suffix : "");

  String get className => localeCode.isEmpty
      ? localeCode
      : localeCode[0].toUpperCase() +
          localeCode.substring(1) +
          (_useSuffix ? _firstCharToUpperCase(_suffix) : "");

  static _firstCharToUpperCase(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  LocaleMap toSuper(String prefix) {
    return LocaleMap(prefix, field, false);
  }

  static const _suffix = "string";
}
