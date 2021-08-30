import 'dart:async';
import 'dart:html';

class FileIO {
  FileUploadInputElement uploadInput = FileUploadInputElement();

  Future<String> loadFile() async {
    uploadInput.click();
    final completer = Completer<String>();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files != null && files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((event) {
          print('done');
          completer.complete(reader.result as String);
        });

        reader.onError.listen((event) {
          completer.completeError(event);
        });

        reader.readAsText(file);
      }
    });
    return completer.future;
  }
}
