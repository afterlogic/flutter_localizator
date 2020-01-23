class ParseException extends Error {
  final String file;
  final String message;

  ParseException(
      this.file,
      this.message,
      );

  @override
  String toString() {
    return "${this.runtimeType}\n"
        "\nfile: $file\n"
        "\n$message";
  }
}
