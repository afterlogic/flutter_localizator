import 'package:localizator_interface/localizator_interface.dart';

abstract class S extends SInterface {
  static const test = 0;
  static const text = 1;
  static const text_with_params = 2;
  String get(int id);
}
