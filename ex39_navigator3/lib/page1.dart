import 'package:flutter/material.dart';
import 'page2.dart';
import 'page3.dart';

class Page1 extends StatefulWidget {
  // 멤버변수 : 파라미터로 전달된 값을 받기위해 선언
  String data = '';

  // 교안에 있는 생성자 코드(구 버전에서 사용)
  // Page1({ Key? key, required this.data}) : super(key: key);
  /**
  새로운 현재 버전의 생성자 코드로 required로 선언하면 필수 사항임을
  명시할 수 있다. 즉 생성자 호출시 반드시 값을 받아 초기화 해야한다.
   */
  Page1({ super.key, required this.data});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //첫번째 버튼을 누르면 2페이지를 추가(push)한다.
            ElevatedButton(
              child: const Text('2페이지 추가',
                                style: TextStyle(fontSize: 24)),
              onPressed: () async {
                // 멤버변수 data를 빈값으로 변경
                setState(() {
                  widget.data = '';
                });

                /**
                Page2를 스택에 추가한다. 즉 전환이 아니라 페이지를
                추가한다. 최초 push했을때는 문제가 없지만, pop을 통해
                Page2가 종룔될때 Null에 대한 오류가 생기므로 Nullable로
                처리해야한다. (Nullable => ? 로 표기)
                 */
                String? value = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    //Page2를 추가하면서 파라미터를 전달한다.
                    builder: (context) => Page2(
                      data: '1페이지에서 보냄 (1->2)'
                    )),
                );

                /**
                앞에서 Page2를 push해서 스택에 추가하면 아래 코드는 바로
                실행되지 않고 await하게된다. 즉 Page2가 제거될때까지
                대기했다가 닫히는 순간 아래 코드가 실행된다.
                Page2에서 콜백해준 데이터를 여기서 출력한다.
                 */
                print('result(1-1) : $value');
                // 만약 null이 들어왔다면 우측의 문자열을 변수에 대입한다.
                setState(() {
                  widget.data = value ?? 'Null ㅜㅜ';
                });
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              child: const Text('3페이지 추가',
                                style: TextStyle(fontSize: 24),),
              onPressed: () async {
                setState(() {
                  widget.data = '';
                });

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Page3(
                      data:'1페이지에서 보냄 (1->3)',
                    )),
                  ).then((value) {
                    print('result(1-2): $value');
                    setState(() {
                      widget.data = value ?? '림진석 왔다감';
                    });
                  });
              },
            ),
            //Page1에서 전송한 파라미터를 여기서 출력
            Text(widget.data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}