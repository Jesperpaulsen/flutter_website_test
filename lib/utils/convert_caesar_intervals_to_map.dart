import 'package:flutter_website_test/models/caesar_interval.dart';
import 'package:flutter_website_test/models/caesar_maps.dart';

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
