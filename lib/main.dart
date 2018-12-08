import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var text = "Hello";
  var widgets = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void _updateText() {
    setState(() {
      text += " Flutter";
    });
  }

  void load() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(url);
    setState(() {
      widgets = json.decode(response.body);
    });
  }

  _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(
          GestureDetector(
            child: Padding(padding: EdgeInsets.all(10.0), child: Text("Row $i")),
            onTap: () {
              print('tapper');
            },
          )
      );
    }
    return widgets;
  }


Widget getBody() {
    if (widgets.length == 0) {
      return CircularProgressIndicator();
    } else {
      return ListView(children: _getListData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: getBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
