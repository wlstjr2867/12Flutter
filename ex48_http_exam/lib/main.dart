import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter 기본형'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Http (Get)',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                _getRequest();
              },
            ),
            ElevatedButton(
              child: const Text('Http (Post)',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                _postRequest();
              },
            ),
          ],
        ),
      ),
    );
  }

  //GET 방식의 통신
  void _getRequest() async {
    var url = Uri.parse("https://sample.bmaster.kro.kr/contacts/686f61d821da65000296eb8a");
    http.Response response = await http.get(
      url,
      headers : {"Accept": "application/json"}
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    print("statusCode: $statusCode");
    print("responseBody: $responseBody");
  }

  //POST 방식의 요청
  void _postRequest() async {
    //새로운 연락처 추가하기
    var url = Uri.parse("https://sample.bmaster.kro.kr/contacts");

    //헤더 및 요청시 전송할 데이터를 JSON형식으로 기술
    http.Response response = await http.post(
      url,
      headers : {"Content-Type": 'application/x-www-form-urlencoded',
      },
      body: {
        "name":"내이름가지고 장난치지마",
        "tel":"010-1111-2222",
        "address":"서울시 종로구"
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    print("statusCode: $statusCode");
    print("responseBody: $responseBody");
  }
}
