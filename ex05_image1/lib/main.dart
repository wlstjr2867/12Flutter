import 'package:flutter/material.dart';
import 'dart:ui';

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

  void getWindowSize() {
    // 앱화면의 논리적 크기
    print(MediaQuery.of(context).size);
    // 화면비율 -> 2.625(Pixel2 에뮬레이터 사용시)
    print(MediaQuery.of(context).devicePixelRatio);
    // 상단 상태 표시줄의 높이
    print(MediaQuery.of(context).padding.top);
    // 앱화면의 실제 크기
    print(window.physicalSize);
  }

  @override
  Widget build(BuildContext context) {

    // 화면의 사이즈 출력을 위한 메서드 호출
    getWindowSize();

    // 실제 화면에 표시되는 UI를 표현하기위한 객체
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // 위젯을 수직방향으로 정렬
      body: Column(
          // 수직 방향에서 가운데 정렬
          mainAxisAlignment: MainAxisAlignment.center,
          // 가로 방향에서 좌측 정렬
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /** 
            현재 배율에 맞는 이미지가 없으므로 기본 이미지를 출력한다.
            즉 녹색이미지가 출력된다. 300a는 하나밖에 없는 상태임.
             */
            Image.asset(
              'assets/images/300x300a.png',
            ),
            Image.asset(
              /**
              해당 배율(3.0x)에 이미지가 있으므로 분홍색 이미지가 출력된다.
              만 이미지가 하나밖에 없다면 노란색 이미지가 출력될것이다. 이처럼
              현재 디바이스(단말기)의화면 배율에 맞는 동일한 이름을 이미지가
              있다면 자동으로 선택해 출력하게된다
               */
              'assets/images/300x300b.png',
            ),
            Image.asset(
              'assets/images/300x300b.png',
              /**
              해당 배율의 이미지라도 크기를 지정하면 지정한 크기가적용된다.
              width 속성으로 이미지가 표현되는 상자의 크기르 지정하고,
              fit 속성으로 가로/세로의 채움 여부를 결정할 수 있다.
               */
              fit: BoxFit.fill,
              width: 150,
            ),
            Image.asset(
              'assets/images/300x300a.png',
              width: 100,
            ),
          ],
        ),
    );
  }
}
