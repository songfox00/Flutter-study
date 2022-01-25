import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memomemo/database/db.dart';
import 'package:memomemo/database/memo.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class WritePage extends StatelessWidget {
  late BuildContext _context;

  String title='';
  String text='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  //키보드 밑으로 내용이 가려질 수도
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: saveDB,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                onChanged: (String title){this.title=title;},
                style: TextStyle(fontSize:30, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.multiline, //입력시 가로가 길 때 줄바꿈되서 보여줌
                maxLines: null, //제한 없음
                //obscureText:true, //password처럼 ***로 나옴
                decoration: InputDecoration(
                  //border: OutlineInputBorder(), //박스가 보임
                  hintText: '제목을 적어주세요.', //labelText과의 차이?
                ),
              ),
              Padding(padding:EdgeInsets.all(20),),
              TextField(
                onChanged: (String text){this.text=text;},
                keyboardType: TextInputType.multiline, //입력시 가로가 길 때 줄바꿈되서 보여줌
                maxLines: 10, //null이면 제한 없음, 키보드 아래로 가려짐 / 단 숫자로 제한하면 자동으로 스크롤됨
                decoration: InputDecoration(
                  hintText: '메모의 내용을 적어주세요.', //labelText과의 차이?
                ),
              )
            ],
          ),
        ));
  }

  Future<void> saveDB() async{
    DBHelper sd=DBHelper();

    var fido=Memo(
      id: Str2sha512(DateTime.now().toString()),
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos());
    Navigator.pop(_context);
  }

  String Str2sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes); //암호화
    return digest.toString();
  }
}
