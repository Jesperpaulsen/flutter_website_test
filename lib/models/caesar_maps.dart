class CaesarMaps {
  final Map<int, String> intToString;
  final Map<String, int> stringToInt;

  CaesarMaps(this.intToString, this.stringToInt);

  int get length {
    return intToString.length;
  }
}
