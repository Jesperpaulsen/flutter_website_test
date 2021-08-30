import 'package:flutter/material.dart';
import 'package:flutter_website_test/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caesar App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: CaesarHome(),
    );
  }
}

class CaesarHome extends StatefulWidget {
  @override
  _CasarHomeState createState() => _CasarHomeState();
}

class _CasarHomeState extends State<CaesarHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20), child: Home()),
            ],
          ),
        ),
      ),
    );
  }
}
