library localizator;

import 'package:localizator/localizator.dart';

main(List<String> args) async {
  final iterator = args.iterator;
  if (iterator.moveNext()) {
    if (iterator.current == "generate" || iterator.current == "g") {
      return _generate(iterator);
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

  while (iterator.moveNext() == true) {
    final current = iterator.current;
    if (current == "-from" || current == "-f") {
      arg = _GenArg.from;
    } else if (current == "-to" || current == "-t") {
      arg = _GenArg.to;
    } else if (current == "-help" || current == "-h") {
      print("   -from | -f            json folder or file path\n");
      print("   -to | -t              out dart path\n");
      return;
    } else {
      if (arg == _GenArg.from) {
        from = current;
      } else if (arg == _GenArg.to) {
        to = current;
      }
      arg = null;
    }
  }
  assert(from != null);
  assert(to != null);

  await localizator(
    from,
    to,
  );
}

enum _GenArg { from, to, help }
