import 'dart:ui';

//// ignore_for_file: non_constant_identifier_names
//// ignore_for_file: camel_case_types
//// ignore_for_file: prefer_single_quotes

import 's.dart';

class EnString extends S {
  final Locale locale = Locale("en");
  final String key = "value";
  String function(String dynamic) => "text $dynamic";
  final String usage_$ = "text \$text_again";
  final String multiLine = "text\ntext";
}
