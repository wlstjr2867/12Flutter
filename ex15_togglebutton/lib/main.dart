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
  var isSelected1 = [false, false, true];
  var isSelected2 = [false, false, true];
  var isSelected3 = [false, false, true];

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
            const Text('multi-select', textScaleFactor: 2),
            // 토글버튼 위젯
            ToggleButtons(
              // 이벤트 핸들러 : 누른 버튼의 인덱스 값이 인수로 전달됨
              onPressed: (int index) {
                setState(() {
                  /**
                  ! 가 변수 앞에 있으므로 Not(부정)연산자로 사용된다.
                  즉 버튼을 클릭할때마다 상태가 반전된다.
                   */
                  isSelected1[index] = !isSelected1[index];
                  // 셀렉트 된 항목 전체를 리스트로 출력
                  print('isSelected1 : $isSelected1');
                  // 선택한 항목의 인덱스 출력
                  print('index : $index');
                });
              },
              // 각 버튼의 값으로 사용할 List를 설정함
              isSelected: isSelected1,
              // 토글버튼을 주로 아이콘으로 표현함
              children: const[
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
            ),
            const SizedBox(height: 20),
            //single selecct
            const Text('single select', textScaleFactor: 2),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // 전체 항목 중 선택한 하나만 토글함
                  for (var i=0; i< isSelected2.length; i++){
                    if(i == index){
                      // 사용자가 선택한 항목 하나만 활성화
                      isSelected2[i] = true;
                    }
                    else{
                      // 나머지는 모두 비활성화 처리
                      isSelected2[i] = false;
                    }
                  }
                });
              },
              isSelected: isSelected2,
              children: const[
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
            )
          ],
        ),
      ),
    );
  }
}
