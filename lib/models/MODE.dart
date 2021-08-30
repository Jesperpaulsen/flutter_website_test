import 'package:flutter_website_test/services/capitalize.dart';

enum MODE { DECRYPT, ENCRYPT }

extension ToShortString on MODE {
  String toShortString() {
    return this.toString().split('.').last.capitalize();
  }
}

extension Toggle on MODE {
  MODE toggle() {
    return this == MODE.ENCRYPT ? MODE.DECRYPT : MODE.ENCRYPT;
  }
}
