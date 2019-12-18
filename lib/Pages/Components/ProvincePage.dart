import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class province_page extends StatefulWidget {
  String countryId;
  province_page(this.countryId);
  @override
   _province_page createState() =>  _province_page(this.countryId);
}

class  _province_page extends State<province_page> {
  String countryId;
  _province_page(this.countryId);

  var provinceData;

  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  String hostIP = "192.168.1.12";
  String port = "8750";

  Future getProvinceList()async{
    var res = await http.get('http://${hostIP}:${port}/getProvinceList?countryId=${countryId}');
    setState(() {
      provinceData = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvinceList();
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
                  itemCount: provinceData == null ? 0: provinceData.length,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop({'province_id':provinceData[index]['PROVINCE_ID'].toString(),'province_name':provinceData[index]['PROVINCE_NAME']});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xffcbcbcb), width: 1))),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25),
                        height: 47,
                        child: Text (provinceData[index]['PROVINCE_NAME'],
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
