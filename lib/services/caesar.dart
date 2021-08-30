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

convertCharCodeToString(int charCode) => String.fromCharCode(charCode);

class CaesarMaps {
  final Map<int, String> intToString;
  final Map<String, int> stringToInt;

  CaesarMaps(this.intToString, this.stringToInt);

  int get length {
    return intToString.length;
  }
}

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

CaesarMaps convertCaesarIntervalsToMap(
    {List<CaesarInterval> intervals = const [],
    List<String> explicitChars = const []}) {
  final Map<int, String> intToString = {};
  final Map<String, int> stringToInt = {};

  var mapIndex = 0;
  for (final interval in intervals) {
    final maps = interval.toMaps(mapIndex);
    intToString.addAll(maps.intToString);
    stringToInt.addAll(maps.stringToInt);
    mapIndex += maps.length;
  }
  for (final char in explicitChars) {
    final interval = new CaesarInterval(start: char.runes.first);
    final maps = interval.toMaps(mapIndex);
    intToString.addAll(maps.intToString);
    stringToInt.addAll(maps.stringToInt);
    mapIndex += maps.length;
  }
  return new CaesarMaps(intToString, stringToInt);
}
