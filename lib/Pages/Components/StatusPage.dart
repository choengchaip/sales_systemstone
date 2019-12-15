import 'package:flutter/material.dart';

class status_page extends StatefulWidget {
  @override
  _status_page createState() => _status_page();
}

class _status_page extends State<status_page> {
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  var statusData = {
    "good": [
      "ให้เข้าไปนำเสนอเพิ่มเติม",
      "กำลังนำเสนอราคา",
      "รอ PO จากลูกค้า",
      "เป็นลูกค้าอยู่แล้ว",
    ],
    "normal": [
      "สนใจแต่กำลังศึกษา",
      "ขอทดลองใช้ก่อน",
      "User < 5",
      "อื่นๆ",
    ],
    "bad": [
      "ยังไม่สนใจ",
      "ติดต่อไม่ได้",
    ]
  };

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
    double _paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: _paddingTop,
              color: Color(0xff3D73BC),
            ),
            Container(
              alignment: Alignment.center,
              height: 73,
              color: Color(0xff3D73BC),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "สถานะงาน",
                      style: topStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 73,
                      width: 60,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: (statusData['good'].length +
                          statusData['normal'].length +
                          statusData['bad'].length) +
                      3,
                  itemBuilder: (BuildContext context, int index) {
                    int realIndex = 0;
                    String realKey = "good";
                    if (index == 0) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Color(0xffCDE3CC),
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffcbcbcb), width: 1))),
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        height: 47,
                        child: Text(
                          "ดี",
                          style: companyStyle,
                        ),
                      );
                    } else if (index == 5) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Color(0xffE1E3CC),
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffcbcbcb), width: 1))),
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        height: 47,
                        child: Text(
                          "ทั่วไป",
                          style: companyStyle,
                        ),
                      );
                    } else if (index == 10) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Color(0xffE3CCCC),
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffcbcbcb), width: 1))),
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        height: 47,
                        child: Text(
                          "แย่",
                          style: companyStyle,
                        ),
                      );
                    }
                    if (index > 10) {
                      realIndex -= 11;
                      realKey = 'bad';
                    } else if (index > 5) {
                      realIndex -= 6;
                      realKey = 'normal';
                    } else if (index > 0) {
                      realIndex -= 1;
                      realKey = 'good';
                    }
                    realIndex += index;

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pop(statusData[realKey][realIndex]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffcbcbcb), width: 1))),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25),
                        height: 47,
                        child: Text(statusData[realKey][realIndex],
                            style: headerDetial),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
