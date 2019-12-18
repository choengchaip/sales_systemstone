import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'InfomationPage.dart';
import 'ProgressPage.dart';
import 'ProspectPage.dart';

class company_page extends StatefulWidget {
  String userId;
  company_page(this.userId);
  @override
  _company_page createState() => _company_page(this.userId);
}

class _company_page extends State<company_page> {
  String userId;
  _company_page(this.userId);
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextEditingController _companyName = TextEditingController();
  List<dynamic> companyData;

  String hostIP = "10.0.2.2";
  String port = '8750';

  Future searchCompanyRequest() async {
    List<dynamic> tmp_data = List<dynamic>();
    var res = await http.get(
        'http://${hostIP}:${port}/getCompanyList?userId=${userId}&companyName=${_companyName.text}');
    tmp_data = jsonDecode(res.body);
    setState(() {
      companyData = tmp_data;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    searchCompanyRequest();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
    return Container(
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
            child: Text(
              "รายชื่อลูกค้า Freemium",
              style: topStyle,
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: 25, bottom: 25, left: 15, right: 15),
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Color(0xffB2B2B2))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: _companyName,
                              onChanged: (String value) {
                                searchCompanyRequest();
                              },
                              decoration: InputDecoration.collapsed(
                                  hintText: "ใส่ชื่อบริษัท"),
                            ),
                          ),
                        ),
                        Container(
                          width: 42,
                          child: Icon(
                            Icons.search,
                            color: Color(0xff7B7B7B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: companyData == null ? 0 : companyData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 100,
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15),
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 15),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        companyData[index]['COMPANY_NAME'],
                                        style: companyStyle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 31,
                                    color: Color(0xffF7F7F7),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return prospect_page(
                                                    companyData[index]
                                                            ['COMPANY_ID']
                                                        .toString(),
                                                    userId);
                                              }));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 7, bottom: 7),
                                              child: Image.asset(
                                                "assets/images/money.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return info_page(
                                                    companyData[index]
                                                            ['COMPANY_ID']
                                                        .toString(),
                                                    userId);
                                              }));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 7, bottom: 7),
                                              child: Image.asset(
                                                "assets/images/info.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return progress_page(
                                                    companyData[index]
                                                            ['COMPANY_ID']
                                                        .toString(),
                                                    userId);
                                              }));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 7, bottom: 7),
                                              child: Image.asset(
                                                "assets/images/comment.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
