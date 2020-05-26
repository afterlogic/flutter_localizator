extension CaseUtil on String {
  String get firstToLower {
    if (this.isEmpty) {
      return this;
    } else {
      return this[0].toLowerCase() + this.substring(1);
    }
  }

  String get firstToUpper {
    if (this.isEmpty) {
      return this;
    } else {
      return this[0].toUpperCase() + this.substring(1);
    }
  }

}
