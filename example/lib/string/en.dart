import 'dart:convert';
import 's.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class EnS extends S {
  final _path = "res/en.json";
  final Locale locale = Locale("en");
  @override
  final Map<String, String> map;

  EnS._(this.map);

  Future<EnS> load() async {
    final map = jsonDecode(await rootBundle.loadString(_path));
    return EnS._(map);
  }
}
