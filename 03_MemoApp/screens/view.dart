import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memomemo/database/memo.dart';
import 'package:memomemo/database/db.dart';
import 'edit.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context, //부모와 상호동작(widget의 구문을 넘겨줌)
                    CupertinoPageRoute(
                        builder: (context) => EditPage(id: widget.id))
                ); //push(): 현재 페이지 위로 올라옴
              },
            ),
          ],
        ),
        body: Padding(padding: EdgeInsets.all(10), child: LoadBuilder()));
  }

  Future<List<Memo>> loadMemo(String id) async {
    DBHelper sd = DBHelper();
    return await sd.findMemo(id);
  }

  LoadBuilder() {
    return FutureBuilder<List<Memo>>(
      future: loadMemo(widget.id),
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
        if ((snapshot.data as List).length == 0) {
          return Container(child: Text("데이터를 불러올 수 없습니다."));
        } else {
          Memo memo = (snapshot.data as List)[0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100,
                child: SingleChildScrollView(
                  child: Text(memo.title,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                ),
              ),
              Text(
                "메모를 만든 시간:" + memo.createTime.split('.')[0],
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.end,
              ),
              Text(
                "메모 수정 시간:" + memo.editTime.split('.')[0],
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.end,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                  child: SingleChildScrollView(child: Text(memo.text))),
            ],
          );
        }
      },
    );
  }
}
