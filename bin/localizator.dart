library localizator;

import 'package:localizator/localizator.dart';
import 'package:localizator/src/model/config.dart';

main(List<String> args) async {
  final iterator = args.iterator;
  final config = Config();
  next() => iterator.moveNext() ? iterator.current : null;
  while (iterator.moveNext()) {
    final current = iterator.current;
    switch (current) {
      case "-from":
        config.inputPath = next();
        break;
      case "-to":
        config.outputPath = next();
        break;
      case "-mask":
        config.fileMask = next();
        break;
    }
  }
  localizator(config);
}
