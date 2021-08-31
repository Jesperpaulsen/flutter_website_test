import 'package:flutter_website_test/models/caesar_maps.dart';
import 'package:flutter_website_test/utils/convert_char_code_to_string.dart';

class CaesarInterval {
  final int start;
  final int? stop;

  CaesarInterval({required this.start, this.stop});

  CaesarMaps toMaps(int startIndex) {
    final charCodeStringStart = convertCharCodeToString(start);
    if (stop == null)
      return new CaesarMaps(
          {startIndex: charCodeStringStart}, {charCodeStringStart: startIndex});

    final Map<int, String> intToString = {};
    final Map<String, int> stringToInt = {};

    var currentIndex = this.start;
    var indexInMap = startIndex;
    while (currentIndex < this.stop! + 1) {
      final charCodeString = convertCharCodeToString(currentIndex);
      intToString[indexInMap] = charCodeString;
      stringToInt[charCodeString] = indexInMap;
      currentIndex++;
      indexInMap++;
    }
    return new CaesarMaps(intToString, stringToInt);
  }
}
