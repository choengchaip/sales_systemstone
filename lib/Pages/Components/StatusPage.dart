import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class status_page extends StatefulWidget {
  @override
  _status_page createState() => _status_page();
}

class _status_page extends State<status_page> {
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  String hostIP = "192.168.1.12";
  String port = "8750";

  var statusData;

  Future getStatusList()async{
    var res = await http.get('http://${hostIP}:${port}/getStatusList');
    var statusJson = jsonDecode(res.body);
    var good = [];
    var normal = [];
    var bad = [];
    var s = {};
    for(int i=0;i<statusJson.length;i++){
      var tmp = {};
      if(i<4){
        tmp['status_id'] = statusJson[i]['SALE_STATUS_ID'];
        tmp['status_name'] = statusJson[i]['SALE_STATUS_NAME'];
        good.add(tmp);
      }else if(i<8){
        tmp['status_id'] = statusJson[i]['SALE_STATUS_ID'];
        tmp['status_name'] = statusJson[i]['SALE_STATUS_NAME'];
        normal.add(tmp);
      }else if(i>=8){
        tmp['status_id'] = statusJson[i]['SALE_STATUS_ID'];
        tmp['status_name'] = statusJson[i]['SALE_STATUS_NAME'];
        bad.add(tmp);
      }
    }
    s['good'] = good;
    s['normal'] = normal;
    s['bad'] = bad;
    setState(() {
      statusData = s;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatusList();
  }

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
                  itemCount: statusData == null ? 0 : (statusData['good'].length + statusData['normal'].length + statusData['bad'].length +3),
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
                        child: Text(statusData[realKey][realIndex]['status_name'],
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
