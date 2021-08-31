import 'package:flutter_website_test/models/caesar_interval.dart';
import 'package:flutter_website_test/utils/convert_caesar_intervals_to_map.dart';

class Caesar {
  late Map<int, String> _fromIntToString;
  late Map<String, int> _fromStringToInt;
  int numberOfShifts;

  Caesar({
    this.numberOfShifts = 5,
    required List<CaesarInterval> intervals,
    required List<String> explicitChars,
  }) {
    final maps = convertCaesarIntervalsToMap(
        intervals: intervals, explicitChars: explicitChars);
    _fromIntToString = maps.intToString;
    _fromStringToInt = maps.stringToInt;
  }

  void setNumberOfShifts(int numberOfShifts) {
    this.numberOfShifts = numberOfShifts;
  }

  String get alphabet {
    return _fromIntToString.entries.map((e) => e.value).join(', ');
  }

  String _sanitizeMessage(
      {required String stringToSanitize, required bool isEncryption}) {
    var res = new StringBuffer();

    for (final char in stringToSanitize.split('')) {
      if (!_fromStringToInt.containsKey(char)) {
        print('Unknown char $char encountered. Skipping...');
        continue;
      }
      final currentIndex = _fromStringToInt[char]!;
      final sumOfIndexes = isEncryption
          ? currentIndex + numberOfShifts
          : currentIndex - numberOfShifts;
      final newIndex = sumOfIndexes % _fromIntToString.length;
      res.write(_fromIntToString[newIndex]);
    }
    return res.toString();
  }

  String encrypt(String stringToEncrypt) {
    return _sanitizeMessage(
        stringToSanitize: stringToEncrypt, isEncryption: true);
  }

  String decrypt(String stringToDecrypt) {
    return _sanitizeMessage(
        stringToSanitize: stringToDecrypt, isEncryption: false);
  }
}
