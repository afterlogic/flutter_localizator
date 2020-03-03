import 'dart:convert';
import 's.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class EnS extends S {
  final _path = "res/en.json";
  final Locale locale = Locale("en");

  Future load() async {
    map = jsonDecode(await rootBundle.loadString(_path));
  }

  @override
  Map<String, String> map;
}
