import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class district_page extends StatefulWidget {
  String provinceId;
  district_page(this.provinceId);
  @override
   _district_page createState() =>  _district_page(this.provinceId);
}

class  _district_page extends State<district_page> {
  String provinceId;
  _district_page(this.provinceId);
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  String hostIP = "192.168.1.12";
  String port = "8750";

  var districtData;

  Future getDistrictList()async{
    var res = await http.get('http://${hostIP}:${port}/getDistrictList?provinceId=${provinceId}');
    setState(() {
      districtData = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getDistrictList();
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
                  itemCount: districtData == null ? 0 : districtData.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop({'district_id':districtData[index]['DISTRICT_ID'].toString(),'district_name':districtData[index]['DISTRICT_NAME']});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffcbcbcb), width: 1))),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25),
                        height: 47,
                        child: Text (districtData[index]['DISTRICT_NAME'],
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
