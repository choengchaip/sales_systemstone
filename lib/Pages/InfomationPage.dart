import 'dart:convert';

import 'package:flutter/material.dart';
import 'Components/CountryPage.dart';
import 'Components/ProvincePage.dart';
import 'Components/DistrictPage.dart';
import 'package:http/http.dart' as http;

class info_page extends StatefulWidget {
  String companyId;
  String userId;
  info_page(this.companyId, this.userId);
  @override
  _info_page createState() => _info_page(this.companyId, this.userId);
}

class _info_page extends State<info_page> {
  String companyId;
  String userId;
  _info_page(this.companyId, this.userId);

  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  TextEditingController _contactText = TextEditingController(text: "กำลังโหลด");
  TextEditingController _telText = TextEditingController(text: "กำลังโหลด");
  TextEditingController _addressText = TextEditingController(text: "กำลังโหลด");
  String country;
  String countryId;
  String province;
  String provinceId;
  String district;
  String districtId;
  String companyName;

  String hostIP = "192.168.1.12";
  String port = "8750";
  var companyInfo;

  Future getCompanyName() async {
    var res = await http
        .get('http://${hostIP}:${port}/getCompanyName?companyId=${companyId}');
    setState(() {
      companyName = res.body;
    });
    getCompanyInfo();
  }

  Future getCompanyInfo() async {
    var tmp_companyInfo = {};
    var tmp;
    var res = await http
        .get('http://${hostIP}:${port}/getCompanyInfo?companyId=${companyId}');
    tmp = jsonDecode(res.body);
    if (tmp.length > 0) {
      tmp_companyInfo['company_name'] = tmp[0]['COMPANY_NAME'];
      tmp_companyInfo['company_tel'] = tmp[0]['TEL_NO'];
      tmp_companyInfo['company_address'] = tmp[0]['ADDRESS'];
      tmp_companyInfo['company_country'] = tmp[0]['COUNTRY_NAME'];
      tmp_companyInfo['company_countryId'] = tmp[0]['COUNTRY_ID'];
      tmp_companyInfo['company_province'] = tmp[0]['PROVINCE_NAME'];
      tmp_companyInfo['company_provinceId'] = tmp[0]['PROVINCE_ID'];
      tmp_companyInfo['company_district'] = tmp[0]['DISTRICT_NAME'];
      tmp_companyInfo['company_districtId'] = tmp[0]['DISTRICT_ID'];
      tmp_companyInfo['company_contact'] = tmp[0]['CONTACT_POINT'];
      setState(() {
        companyInfo = tmp_companyInfo;
        _contactText.text = companyInfo['company_contact'];
        _telText.text = companyInfo['company_tel'];
        _addressText.text = companyInfo['company_address'];
        country = companyInfo['company_country'];
        countryId = companyInfo['company_countryId'].toString();
        province = companyInfo['company_province'];
        provinceId = companyInfo['company_provinceId'].toString();
        district = companyInfo['company_district'];
        districtId = companyInfo['company_districtId'].toString();
      });
    } else {
      _contactText.clear();
      _telText.clear();
      _addressText.clear();
    }
  }

  cancelAlert(String key) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(key),
            actions: <Widget>[
              FlatButton(
                child: Text("ตกลง"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future updateCompanyInfo() async {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        });
    if (_contactText.text.isEmpty) {
      Navigator.of(context).pop();
      await cancelAlert("กรุณาใส่ชื่อผู้ติดต่อ");
      return;
    }
    if (_telText.text.isEmpty) {
      Navigator.of(context).pop();
      await cancelAlert("กรุณาใส่เบอร์โทรศัพท์");
      return;
    }
    if (_addressText.text.isEmpty) {
      Navigator.of(context).pop();
      await cancelAlert("กรุณาใส่ที่อยู่");
      return;
    }
    if (countryId == 'null') {
      Navigator.of(context).pop();
      await cancelAlert("กรุณาเลือกประเทศ");
      return;
    }
    if (provinceId == 'null') {
      Navigator.of(context).pop();
      await cancelAlert("กรุณาเลือกจังหวัด");
      return;
    }
    if (districtId == 'null') {
      Navigator.of(context).pop();
      await cancelAlert("กรุณาเลือกอำเภอ");
      return;
    }

    var res =
        await http.post('http://${hostIP}:${port}/updateCompanyInfo', body: {
      'contact_point': _contactText.text,
      'tel': _telText.text,
      'address': _addressText.text,
      'countryId': countryId,
      'provinceId': provinceId,
      'districtId': districtId,
      'userId': userId,
      'companyId': companyId
    });
    Navigator.of(context).pop();
    var tmp = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("บันทึกสำเร็จ"),
            actions: <Widget>[
              FlatButton(
                child: Text("ตกลง"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    getCompanyName();
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
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "บริษัท",
                              style: headerDetial,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              companyName == null ? "กำลังโหลด" : companyName,
                              style: companyStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "ชื่อผู้ติดต่อ",
                              style: headerDetial,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      controller: _contactText,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                      style: headerDetial,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "เบอร์โทรศัพท์",
                              style: headerDetial,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      controller: _telText,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                      style: headerDetial,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "ที่อยู่",
                              style: headerDetial,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      controller: _addressText,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                      style: headerDetial,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "ประเทศ",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var tmp_country = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return country_page();
                              }));
                              setState(() {
                                if (tmp_country != null) {
                                  province = null;
                                  provinceId = null;
                                  district = null;
                                  districtId = null;
                                  country = tmp_country['country_name'];
                                  countryId =
                                      tmp_country['country_id'].toString();
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        child: Text(country == null
                                            ? "กรุณาเลือกประเทศ"
                                            : country)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 4, bottom: 5),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "จังหวัด",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var tmp_province = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return province_page(countryId);
                              }));
                              setState(() {
                                if (tmp_province != null) {
                                  provinceId = tmp_province['province_id'];
                                  province = tmp_province['province_name'];
                                  district = null;
                                  districtId = null;
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        child: Text(province == null
                                            ? "กรุณาเลือกจังหวัด"
                                            : province)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 4, bottom: 5),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "อำเภอ",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var tmp_district = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return district_page(provinceId);
                              }));
                              setState(() {
                                if (tmp_district != null) {
                                  districtId = tmp_district['district_id'];
                                  district = tmp_district['district_name'];
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        child: Text(district == null
                                            ? "กรุณาเลือกอำเภอ"
                                            : district)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 4, bottom: 5),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                updateCompanyInfo();
              },
              child: Container(
                alignment: Alignment.center,
                height: 59,
                color: Color(0xff4F6E4B),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "บันทึก",
                    style: topStyle,
                  ),
                ),
              ),
            ),
            Container(
              height: _paddingBottom,
              color: Color(0xff4F6E4B),
            ),
          ],
        ),
      ),
    );
  }
}
