import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'write.dart';
import 'package:memomemo/database/memo.dart';
import 'package:memomemo/database/db.dart';
import 'view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 40),
            child: Container(
              child: Text('메모장',
                  style: TextStyle(fontSize: 30, color: Color(0xffFF7F50))),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(child: memoBuilder(context))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, //부모와 상호동작(widget의 구문을 넘겨줌)
                CupertinoPageRoute(
                    builder: (context) => WritePage())); //push(): 현재 페이지 위로 올라옴
          },
          tooltip: '노트를 추가하려면 클릭하세요',
          label: Text('메모 추가'),
          icon: Icon(Icons
              .add)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    await sd.deleteMemo(id);
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                  //상태가 바뀌면
                  deleteMemo(deleteId);
                });
                deleteId = '';
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }

  memoBuilder(BuildContext parentContext) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if ((projectSnap.data as List).length == 0) {
          return Container(
              alignment: Alignment.center,
              child: Text(
                  '지금 바로 "메모 추가" 버튼을 눌러\n 새로운 메모를 추가해주세요!\n\n\n\n\n\n\n\n',
                  style: TextStyle(fontSize: 15, color: Colors.black38),
                  textAlign: TextAlign.center));
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          itemCount: (projectSnap.data as List).length,
          itemBuilder: (context, index) {
            Memo memo = (projectSnap.data as List)[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    parentContext,
                    CupertinoPageRoute(
                        builder: (context) => ViewPage(id: memo.id)));
              },
              onLongPress: () {
                //길게 누르면 동작
                deleteId = memo.id;
                showAlertDialog(parentContext);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                            memo.title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,  //오버플로우 되면 생략 ...
                        ),
                        Text(memo.text, style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "최종 수정 시간: " + memo.editTime.split('.')[0],
                          style: TextStyle(fontSize: 11),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xffFFA500),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(color: Color(0xffFFA500), blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        );
      },
      future: loadMemo(),
    );
  }
}
