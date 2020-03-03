import 'dart:io';

String preparePath(String path) {
  return path.replaceAll(RegExp("\/|\\\\"), Platform.pathSeparator);
}

String getFileName(File file) {
  return file.path.split(Platform.pathSeparator).last;
}
