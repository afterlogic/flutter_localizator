import 'dart:ui';
import 's.dart';

class RuString extends S {
  final Locale locale = Locale("ru");
  final String key = "значение";
  String function(String dynamic) => "текст $dynamic";
  final String usage_$ = "текст \$тоже_текст";
}
