import 'dart:io';

String preparePath(String path) {
  return path.replaceAll(RegExp("\/|\\\\"), Platform.pathSeparator);
}

String getFileLocale(File file) {
  return getFileName(file).split(".").first;
}

String getFileName(File file) {
  return file.path.split(Platform.pathSeparator).last;
}
