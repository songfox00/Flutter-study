import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isStared = true;
  int _count = 41;

  @override
  Widget build(BuildContext context) {
    var titleSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, //왼쪽 정렬
          children: <Widget>[
            Text("Oeschinen Lake Comapground",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20)), //텍스트 스타일 주기
            Text("Kandresteg, Switzerland",
                style: TextStyle(color: Colors.grey, fontSize: 20)),
          ],
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        IconButton(
            onPressed: _pressedStar,
            icon: (_isStared ? Icon(Icons.star) : Icon(Icons.star_border)),
            iconSize: 25,
            color: Colors.deepOrange),
        Text('$_count', style: TextStyle(fontSize: 22))
      ],
    );
    var bottonSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.call, size: 37, color: Colors.lightBlue),
            Padding(
              padding: EdgeInsets.all(3.0),
            ),
            Text('CALL', style: TextStyle(color: Colors.lightBlue))
          ],
        ),
        Padding(padding: EdgeInsets.all(40.0)),
        Column(children: <Widget>[
          Icon(Icons.near_me, size: 37, color: Colors.lightBlue),
          Padding(
            padding: EdgeInsets.all(3.0),
          ),
          Text('ROUTE', style: TextStyle(color: Colors.lightBlue))
        ]),
        Padding(padding: EdgeInsets.all(40.0)),
        Column(children: <Widget>[
          Icon(Icons.share, size: 37, color: Colors.lightBlue),
          Padding(
            padding: EdgeInsets.all(3.0),
          ),
          Text('SHARE', style: TextStyle(color: Colors.lightBlue))
        ])
      ],
    );
    var textSection = Container(
      child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          style: TextStyle(fontSize: 18)),
      padding: EdgeInsets.all(30.0),
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.network(
              "https://cdn.pixabay.com/photo/2020/07/27/02/09/tent-5441144_960_720.jpg",
              height: 240,
              width: 600,
              fit: BoxFit.cover), //인터넷 이미지 출력
          Padding(padding: EdgeInsets.all(12.0)),
          titleSection,
          Padding(padding: EdgeInsets.all(10.0)),
          bottonSection,
          //Padding(padding: EdgeInsets.all(7.0)),
          textSection
        ],
      ),
    );
  }

  void _pressedStar() {
    setState(() {
      //상태가 변화됐을 때 트리거 역할
      if (_isStared) {
        _isStared = false;
        _count -= 1;
      } else {
        _isStared = true;
        _count += 1;
      }
    });
  }
}
