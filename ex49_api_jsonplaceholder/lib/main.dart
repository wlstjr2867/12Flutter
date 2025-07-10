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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('jsonplaceholder 파싱',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                getRequest();
              },
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              child: const Text('jsonplaceholder 파싱2',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                getRequest2();
              },
            )
          ],
        ),
      ),
    );
  }

  void getRequest() async {
    //API 사이트에서 하나의 게시물을 얻오온 후 파싱
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");

    //get방식의 요청을 통해 응답이 올때까지 기다린 후 응답데이터 저장
    http.Response response = await http.get(
      url,
      headers: {"Accept": "application/json"}
    );

    //응답데이터
    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);
    // print("statusCode: $statusCode");
    // print("responseBody: $responseBody");

    //1차파싱
    var jsonData = jsonDecode(responseBody);
    // print(jsonData);
    //각 key를 이용해서 데이터 인출 
    String userId = jsonData['userId'].toString();
    String id = jsonData['id'].toString();
    String title = jsonData['title'];
    String body = jsonData['body'];

    //콘솔에 결과  출력
    print("userId: $userId");
    print("id: $id");
    print("title: $title");
    print("body: $body");
  }

  void getRequest2() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    http.Response response = await http.get(
      url,
      headers: {"Accept": "application/json"}
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);
    print("responseBody: $responseBody");

    //1차파싱
    var jsonData = jsonDecode(responseBody);
    // print(jsonData);
    //각 key를 이용해서 데이터 인출 
    for(var row in jsonData){
      String userId = row['userId'].toString();
      String id = row['id'].toString();
      String title = row['title'];
      String body = row['body'];

      //콘솔에 결과  출력
      print("userId: $userId");
      print("id: $id");
      print("title: $title");
      print("body: $body");
    }
  }
}
