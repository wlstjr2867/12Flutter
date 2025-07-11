//http통신, XML을 JSON으로 변환하기 위한 패키지 임포트
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml2json/xml2json.dart';

//'stful' 자동완성 기능을 이용해서 페이지를 구성할 클래스 생성
class MyListViewPage01 extends StatefulWidget {
  const MyListViewPage01({super.key});

  @override
  State<MyListViewPage01> createState() => _MyListViewPage01State();
}

class _MyListViewPage01State extends State<MyListViewPage01> {

  //파싱한 병원정보 저장을 위한 리스트 
  late List<HospitalVO> HospitalList;
  //화면의 리렌더링을 위한 변수. setState() 안에서 변경할 예정.
  int stateFlag = 0;

  //공공데이터 요청 URL과 파라미터 정리
  String requestURL = 'http://apis.data.go.kr/openapi/service/rest/HmcSearchService/getRegnHmcList';
  String serviceKeyTxt = 'BCmcgV3Q0yhGx057IJqllIWuLfbH3E3p30h0jYrb2sH6za5Y%2Bu7oDg8%2F0h1w7uMhSBluVcb60pP2vhMay3yuNA%3D%3D';
  String hmcNmTxt = ''; //검진기관명
  String siDoCdTxt = '11'; //시도코드
  String siGunGuCdTxt = '110'; //시군구코드
  String numOfRowsTxt = '100'; //검색갯수

  @override
  void initState() {
    super.initState();
    // 앱 실행시 통신을 위한 함수를 즉시 실행한다.
    HospitalList = []; //초기화
    _getDataParsing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('국민건강보험공단_검진기관 찾기'),
      ),
      //리스트뷰 위젯으로 화면 구성
      body: ListView.builder(
        padding : const EdgeInsets.all(8),
        //파싱된 병원정보의 갯수만큼 Lazy하게 타일을 생성 후 추가
        itemCount: HospitalList.length,
        itemBuilder: (BuildContext context, int index) {
          return HospitalTile(HospitalList[index]);
        }
      ),
    );
  }

  void _getDataParsing() async {
    String pm1 = 'serviceKey=$serviceKeyTxt'; 
    String pm2 = 'hmcNm=$hmcNmTxt'; //검진기관명
    String pm3 = 'siDoCd=$siDoCdTxt'; //시도코드
    String pm4 = 'siGunGuCd=$siGunGuCdTxt'; //시군구코드
    String pm5 = 'numOfRows=$numOfRowsTxt'; //출력갯수

    //공공데이터 API 요청
    var url = Uri.parse("$requestURL?$pm1&$pm2&$pm3&$pm4&$pm5");
    // http GET 방식
    http.Response response = await http.get(
      url,
      headers: {"Accept": "application/xml"}
    );
    
    //응답데이터 저장
    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    //XML 데이터를 JSON으로 변환
    Xml2Json xml2json = Xml2Json(); //객체생성
    xml2json.parse(responseBody);   //1차 파싱
    var jsonData = xml2json.toParker(); // XML->JSON으로 변환
    print(jsonData);
    var temp = jsonDecode(jsonData);
    //JSON에서 병원정보의 Key를 찾아서 파싱한다.
    List realData = temp['response']['body']['items']['item'];

    for(var item in realData){
      String cxVl = item['cxVl'].toString();
      String cyVl = item['cyVl'].toString();
      //공공데이터 중에 빈값이 있는 경우 에러가 발생되므로 이에 대한 처리를 해야한다.
      //값이 없다면 'fax없음'이 할당된다.
      String exmdrFaxNo = item['exmdrFaxNo'] ?? 'fax없음';
      String exmdrTelNo = item['exmdrTelNo'];
      String hmcNm = item['hmcNm'];
      String locAddr = item['locAddr'];
      String locPostNo = item['locPostNo'].toString();
      String ykindnm = item['ykindnm'];

      //파싱한 병원정보는 VO에 저장
      HospitalVO vo = HospitalVO(cxVl,cyVl,exmdrFaxNo,exmdrTelNo,hmcNm,locAddr,locPostNo,ykindnm);
      //List에 추가
      HospitalList.add(vo);
    }

    print(HospitalList);
      setState(() {
        stateFlag = 1;
      });
  }
}

//병원정보 저장을 위한 VO 클래스
class HospitalVO {
  String cxVl;
  String cyVl;
  String exmdrFaxNo;
  String exmdrTelNo;
  String hmcNm;
  String locAddr;
  String locPostNo;
  String ykindnm;

  HospitalVO(this.cxVl, this.cyVl, this.exmdrFaxNo, this.exmdrTelNo, this.hmcNm, this.locAddr, this.locPostNo, this.ykindnm);
}

//리스트타일을 생성하기 위한 클래스 정의
class HospitalTile extends StatelessWidget {
  final HospitalVO _hospitalVO;
  HospitalTile(this._hospitalVO);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //아이콘
      leading: Icon(Icons.account_balance),
      //타이틀은 병원명
      title: Text(_hospitalVO.hmcNm,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
          color: Colors.blueAccent),
      ),
      //내용은 주소, 전화번호, 팩스
      subtitle: Text("주소:${_hospitalVO.locAddr}\nTel:${_hospitalVO.exmdrTelNo}"
        +"\nFax:${_hospitalVO.exmdrFaxNo}\n"),
        //우측 아이콘
        trailing: Icon(Icons.arrow_forward_ios),
        //타일을 탭하면 병원명을 콘솔에 출력
        onTap: () {
          print('병원명:${_hospitalVO.hmcNm}');
        },
    );
  }
}