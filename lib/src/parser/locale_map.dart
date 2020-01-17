import 'package:localizator/src/localizator/localization_filed.dart';

class LocaleMap {
  final String localeCode;
  final List<LocalizationField> field;
  final bool useSuffix;

  LocaleMap(this.localeCode, this.field, [this.useSuffix = true]);

  String get fileName => localeCode + (useSuffix ? "_" + suffix : "");

  String get className => localeCode.isEmpty
      ? localeCode
      : localeCode[0].toUpperCase() +
          localeCode.substring(1) +
          (useSuffix ? _firstCharToUpperCase(suffix) : "");

  static _firstCharToUpperCase(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  LocaleMap toSuper(String prefix) {
    return LocaleMap(prefix, field, false);
  }

  static const suffix = "string";
}
