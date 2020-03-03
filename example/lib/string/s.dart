import 'dart:ui';
import 'package:meta/meta.dart';

//// ignore_for_file: non_constant_identifier_names
abstract class S {
  Locale get locale;

  String get test => _string(id.test);
  String get text => _string(id.text);
  String text_with_params(List<String> arg) =>
      _string(id.text_with_params, arg);

  Future load();

  String _string(String id, [List<String> arg]) {
    var string = map[id];
    if (arg == null) {
      return string;
    }
    return format(string, arg);
  }

  static format(String string, List<String> arg) {
    var text = string;
    if (text.contains("%")) {
      if (arg != null) {
        final reversed = RegExp("%s").allMatches(text).toList().reversed;
        if (reversed.length == arg.length) {
          var index = arg.length;
          for (var math in reversed) {
            index--;
            text = text.replaceRange(
              math.start,
              math.end,
              arg[index],
            );
          }
        }
      }
      final reversed = RegExp("%%*").allMatches(text).toList().reversed;
      for (var math in reversed) {
        final group = math.group(0);
        text = text.replaceRange(
          math.start,
          math.end,
          group.substring(1),
        );
      }
    }
    return text;
  }

  @protected
  Map<String, String> get map;

  static const id = _StringId();
}

class _StringId {
  const _StringId();
  String get test => "test";
  String get text => "text";
  String get text_with_params => "text_with_params";
}
