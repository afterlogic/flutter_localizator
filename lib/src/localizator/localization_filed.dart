class LocalizationField {
  final String name;

  final String value;

  final List<String> environment;

  LocalizationField(this.name, this.value, this.environment);

  factory LocalizationField.fromMapEntry(String key, String value) {
    var textValue = "";
    if (value is String) {
      textValue = value;
    } else {
      try {
        textValue = value.toString();
      } catch (e) {
        return null;
      }
    }
    final result = RegExp("\\\\?\\\$\\\w+").allMatches(textValue).toList();
    final environment = <String>[];
    result.forEach((item) {
      final value = item.group(0);
      final startIndex = value.indexOf("\$");
      if (startIndex == 0) {
        environment.add(value.substring(1));
      }
    });
    return LocalizationField(key, textValue, environment);
  }

  static List<LocalizationField> fromMap(Map<String, dynamic> map) {
    final outList = <LocalizationField>[];
    map.forEach((key, value) {
      outList.add(LocalizationField.fromMapEntry(key, value));
    });
    return outList;
  }
}
