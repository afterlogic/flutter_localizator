import 'dart:ui';

//// ignore_for_file: non_constant_identifier_names
//// ignore_for_file: camel_case_types
//// ignore_for_file: prefer_single_quotes

import 's.dart';

class RuString extends S {
  final Locale locale = Locale("ru");
  final String key = "значение";
  String function(String dynamic) => "текст $dynamic";
  final String usage_$ = "текст \$тоже_текст";
  final String multiLine = "тест\rтест";
}
