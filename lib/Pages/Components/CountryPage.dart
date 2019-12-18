import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class country_page extends StatefulWidget {
  @override
  _country_page createState() => _country_page();
}

class _country_page extends State<country_page> {
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  String hostIP = "10.0.2.2";
  String port = "8750";

  var countryData;

  Future getCountryList()async{
    var res = await http.get('http://${hostIP}:${port}/getCountryList');
    setState(() {
      countryData = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryList();
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
                      "บันทึกรายละเอียดบริษัท",
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
                  itemCount: countryData == null ? 0 : countryData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop({'country_id':countryData[index]['COUNTRY_ID'],'country_name':countryData[index]['COUNTRY_NAME']});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffcbcbcb), width: 1))),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25),
                        height: 47,
                        child: Text(countryData[index]['COUNTRY_NAME'],
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
