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
      /**
      방법1 : 명시적으로 ListView의 Children으로 List를 넘겨서 생성한다.
        리스트뷰가 로드될때 데이터까지 한꺼번에 로드되므로 갯수가
        적을때 적합한 방식이다.
       */
      body: ListView(
        //1단계
        // children: [
        //   ListTile(
        //     //좌측 아이콘
        //     leading: FlutterLogo(
        //       size: 50.0,
        //     ),
        //     //타일에 출력할 제목
        //     title: Text('Basic #1'),
        //     //출력할 내용
        //     subtitle: Text('타이틀과 서브 타이틀로만 구성'),
        //     //우측 아이콘
        //     trailing: Icon(Icons.more_vert),
        //     //타일을 눌렀을때의 동작 지정
        //     onTap: () {
        //       print('Basic #1');
        //     },
        //   ),
        // ],

        //2단계
        // children: getMyList1(),
          
        //3단계
        children: getMyList2(),
      )
    );
  }

  //2단계
  // List<Widget> getMyList1() {
  //   List<Widget> myList = [
  //     //리스트 타일은 1단계와 동일하게 작성
  //     ListTile(
  //       leading: FlutterLogo(
  //         size: 50.0,
  //       ),
  //       title: Text('Basic #1'),
  //       subtitle: Text('타이틀과 서브 타이틀로만 구성'),
  //       trailing: Icon(Icons.more_vert),
  //       onTap: () {
  //         print('Basic #1');
  //       },
  //     ),
  //     //리스트뷰의 타일을 구분하는 선
  //     Divider(
  //       color: Colors.black,
  //       height: 5,
  //       // indent: 10,
  //       // endIndent: 10,
  //     )
  //   ];
  //   return myList;
  // }
   
  //3단계 : 데이터를 이용해서 갯수만큼 반복하는 List를 생성
  List<Widget> getMyList2() {
    //Person 인스턴스를 저장할 수 있는 리스트 생성
    List<Person> persons = [];
    for(int i=0; i<15; i++){
      persons.add(Person(i+21, '홍길동$i', true));
    }

    // 앞에서 준비한 데이터를 이용해서 리스트타일 생성
    List<Widget> myList = [];
    for(int i=0; i<persons.length; i++){
      // 리스트타일을 생성한 후 리스트에 추가
      Widget wid = ListTile(
        leading: FlutterLogo(
          size: 50.0,
        ),
          //각 항목의 인덱스르 통해 텍스트 출력
          title: Text('Basic #$i'),
          subtitle: Text('${persons[i].name} - ${persons[i].age}'),
          trailing: Icon(Icons.more_vert),
          onTap: () {
            print('Basic #$i');
          },
      );
      // ListTile 인스턴스 생성 후 List에 추가한다
      myList.add(wid);
    }

    return myList;
  }
}

// 데이터로 사용할 DTO 클래스 
class Person{
  // 멤버변수
  int age;
  String name;
  bool isLeftHand;
  //생성자 : 각 멤버변수를 초기화 하는 축약형 표현방식  
  Person(this.age, this.name, this.isLeftHand);
}