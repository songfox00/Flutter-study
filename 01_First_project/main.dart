import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter Demo Home Page')
    );
  }
}

class MyHomePage extends StatefulWidget { // _MyHomePageState 호출역할
  const MyHomePage({Key? key, required this.title}) : super(key: key); //위에서 넘겨준 title을 쓰기 위해
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  //주요 내용은 여기
  int _counter = 0; //_가 붙으면 class 내부에서만 쓸 수 있음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center( //가운데 정렬
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times: '),
          Text('$_counter', style:Theme.of(context).textTheme.headline3)
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment', //도움말
        child: Icon(Icons.add)
      ),
    );
  }

  void _incrementCounter() {
    setState((){  //변동될 때마다 적용
      _counter++;
    });
  }
}

