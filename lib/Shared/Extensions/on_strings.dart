extension CamelCasing on String {
  String get upperFirstLetter => this[0].toUpperCase() + substring(1);
}
