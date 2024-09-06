extension NumberPadding on num {
  String get lhs0IfSingle {
    if (toString().length == 1) {
      return '0${toString()}';
    } else {
      return toString();
    }
  }
}
