import 'package:flutter/material.dart';
import 'package:flutter_website_test/models/MODE.dart';
import 'package:flutter_website_test/services/caesar.dart';
import 'package:flutter_website_test/services/file_io.dart';
import 'package:flutter_website_test/widgets/button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final caesar = Caesar(intervals: [
    new CaesarInterval(
      start: 97,
      stop: 122,
    )
  ], explicitChars: [
    'æ',
    'ø',
    'å',
    ' ',
    '.'
  ]);
  final fileIO = FileIO();
  final _textController = new TextEditingController();
  final _numberOfShiftController = new TextEditingController();
  var message = '';

  var mode = MODE.DECRYPT;
  var displayMode = MODE.DECRYPT.toShortString();

  Future<void> uploadFile() async {
    final textValue = await fileIO.loadFile();
    setState(() {
      _textController.text = textValue;
    });
  }

  changeMode() {
    final newMode = mode.toggle();
    setState(() {
      mode = newMode;
      displayMode = newMode.toShortString();
    });
  }

  execute() {
    final text = _textController.text;
    if (text.isEmpty) return;
    final result =
        mode == MODE.ENCRYPT ? caesar.encrypt(text) : caesar.decrypt(text);
    setState(() {
      message = result;
    });
  }

  @override
  void initState() {
    setState(() {
      _numberOfShiftController.text = caesar.numberOfShifts.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 40,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Supersecure encryption service',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            constraints: BoxConstraints(maxWidth: 300),
            child: TextField(
              controller: _textController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Message to $displayMode',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 150),
              child: TextField(
                onChanged: (newValue) =>
                    caesar.setNumberOfShifts(int.parse(newValue)),
                controller: _numberOfShiftController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of shifts',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(displayMode, execute),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Button('Change mode', changeMode),
                ),
                Button('Upload file', uploadFile),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: message.isNotEmpty
                ? Text(
                    'Your message is $message',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Loaded alphabet ${caesar.alphabet}',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
