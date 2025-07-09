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
              child: const Text('Show ProgressDialog',
                                style: TextStyle(fontSize: 24)),
              onPressed: () => _showProgressDialog('loading...'),
            ),
          ],
        ),
      ),
    );
  }

  Future _showProgressDialog(String message) async {
    await showDialog(
      context: context,
      // barrierDismissible: true, false : user mutst tap button!
      builder: (BuildContext context) {
        //3초간 대기시간
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
        });

        return Theme(
          data: ThemeData(dialogTheme: DialogThemeData(backgroundColor: Colors.white)),
          child: AlertDialog(
            //대화창의 모서리를 둥글게 처리
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            // 대화창의 외부크기
            content: SizedBox(
              // 높이를 번경
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 인디케이터의 크기 설정
                    const SizedBox(
                      height: 50.0,
                      width: 50.0,
                      //인디케이터의 모양 혹은 색깔 설정
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                        strokeWidth: 5.0,
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    //출력할 메세지
                    Text(
                      message,
                      style: const TextStyle(fontSize: 24, height: 1.5),
                    ),
                  ],
                ),
              ),
            )
          ),
        );
      }
    );
  }
}
