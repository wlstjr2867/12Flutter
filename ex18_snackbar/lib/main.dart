import 'package:flutter/material.dart';

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
  //스낵바에서 사용할 메세지
  String msg = "Hello world";

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
              //버튼 클릭시 실행할 함수를 직접 정의
              child: const Text('SnackBar 기본',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                //이 클래스를 통해 직접 스낵바를 띄운다.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    //스낵바에 표시할 메세지
                    content: Text(msg),
                    // 유지시간을 밀리세컨즈 단위로 설정(1초)
                    duration: const Duration(milliseconds: 1000),
                  ),
                );
              }
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('SackBar 옵션',
                                style: TextStyle(fontSize: 24)),
              // 버특 클릭시 람다 형식으로 외부함수 호출
              onPressed: () => callSanckBar("안녕하세요~ 전우치님!"),
            ),
          ],
        ),
      ),
    );
  }
  //스낵바의 옵션 설정
  callSanckBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //메세지 내용, 텍스트의 스타일을 지정함. 
        content: Text(msg, style: const TextStyle(color: Colors.black,)),
        //스낵바의 배경색
        backgroundColor: Colors.yellow[800],
        //유지시간
        duration: const Duration(milliseconds: 2000),
        //스낵바에 별도의 텍스트버튼 추가
        action: SnackBarAction(
          label: '닫기', 
          textColor: Colors.black,
          onPressed: () {
            print('스낵바 닫힘');
          },
        ),
        /**
        플로팅 여부 설정 : 아래부분에서 살짝 띄워준다. 이 부분이 없으면 기본 설정처럼
        아래쪽에서 스낵바를 밀어 올린다.
         */
        behavior: SnackBarBehavior.floating,
        // 스낵바의 모서리 부분을 둥그게 커스터한다.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color:Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
