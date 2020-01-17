library localizator;

import 'package:localizator/localizator.dart';
import 'package:localizator/new_locale.dart';

main(List<String> args) async {
  final iterator = args.iterator;
  if (iterator.moveNext()) {
    if (iterator.current == "generate" || iterator.current == "g") {
      return _generate(iterator);
    } else if (iterator.current == "new_locale" || iterator.current == "n") {
      return _newLocale(iterator);
    }
  }
  print(
      "you can call \"localizator generate\" for generate dart locale file from json files");

  print("or \"localizator new_locale\" for create new json file with keys");

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

_newLocale(Iterator iterator) async {
  _NewLocaleArg arg;
  String from;
  String baseLocale;
  while (iterator.moveNext() == true) {
    final current = iterator.current;
    if (current == "-from" || current == "-f") {
      arg = _NewLocaleArg.from;
    } else if (current == "-baseLocale" || current == "-b") {
      arg = _NewLocaleArg.baseLocale;
    } else if (current == "-help" || current == "-h") {
      print("   -from | -f            json folder or file path\n");
      print("   -to | -t              out dart path\n");
      print("   -baseLocale | -b      locale for generate S class\n");
      return;
    } else {
      if (arg == _NewLocaleArg.from) {
        from = current;
      } else if (arg == _NewLocaleArg.baseLocale) {
        baseLocale = current;
      }
      arg = null;
    }
  }
  assert(from != null);

  await newLocale(
    from,
    baseLocale,
  );
}

enum _GenArg { from, to, baseLocale, help }

enum _NewLocaleArg { from, baseLocale, help }
