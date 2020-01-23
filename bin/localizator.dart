library localizator;

import 'package:localizator/localizator.dart';
import 'package:localizator/update_locale.dart';

main(List<String> args) async {
  final iterator = args.iterator;
  if (iterator.moveNext()) {
    if (iterator.current == "generate" || iterator.current == "g") {
      return _generate(iterator);
    } else if (iterator.current == "update_locale" || iterator.current == "u") {
      return _updateLocale(iterator);
    }
  }
  print("you can call:");
  print(
      "\"localizator generate\" for generate dart locale file from json files");
  print("");
  print("use \"localizator {function} -help\" for get function arguments");
}

_generate(Iterator iterator) async {
  _GenArg arg;
  String from;
  String to;
  String baseLocale;
  while (iterator.moveNext() == true) {
    final current = iterator.current;
    if (current == "-from" || current == "-f") {
      arg = _GenArg.from;
    } else if (current == "-to" || current == "-t") {
      arg = _GenArg.to;
    } else if (current == "-baseLocale" || current == "-b") {
      arg = _GenArg.baseLocale;
    } else if (current == "-help" || current == "-h") {
      print("   -from | -f            json folder or file path\n");
      print("   -to | -t              out dart path\n");
      print("   -baseLocale | -b      locale for generate S class\n");
      return;
    } else {
      if (arg == _GenArg.from) {
        from = current;
      } else if (arg == _GenArg.to) {
        to = current;
      } else if (arg == _GenArg.baseLocale) {
        baseLocale = current;
      }
      arg = null;
    }
  }
  assert(from != null);
  assert(to != null);

  await localize(
    from,
    to,
    baseLocale,
  );
}

_updateLocale(Iterator iterator) async {
  _UpdateLocaleArg arg;
  String from;
  String baseLocale;
  while (iterator.moveNext() == true) {
    final current = iterator.current;
    if (current == "-from" || current == "-f") {
      arg = _UpdateLocaleArg.from;
    } else if (current == "-baseLocale" || current == "-b") {
      arg = _UpdateLocaleArg.baseLocale;
    } else if (current == "-help" || current == "-h") {
      print("   -from | -f            json folder\n");
      print("   -baseLocale | -b      locale for get keys\n");
      return;
    } else {
      if (arg == _UpdateLocaleArg.from) {
        from = current;
      } else if (arg == _UpdateLocaleArg.baseLocale) {
        baseLocale = current;
      }
      arg = null;
    }
  }
  assert(from != null);

  await updateLocale(
    from,
    baseLocale,
  );
}

enum _GenArg { from, to, baseLocale, help }

enum _UpdateLocaleArg { from, baseLocale, help }

enum _NewLocaleArg { code, from, baseLocale, help }
