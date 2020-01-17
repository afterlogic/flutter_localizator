import 'package:flutter_test/flutter_test.dart';
import 'package:localizator/localizator.dart';

const path="example";
main() {
  test("localizator", () async {
    await localize("$path/res", "$path/lib/string", null);
  });
}
