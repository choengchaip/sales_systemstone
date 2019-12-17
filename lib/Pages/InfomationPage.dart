import 'package:flutter/material.dart';
import 'Components/CountryPage.dart';
import 'Components/ProvincePage.dart';
import 'Components/DistrictPage.dart';

class info_page extends StatefulWidget {
  int companyName;
  info_page(this.companyName);
  @override
  _info_page createState() => _info_page(this.companyName);
}

class _info_page extends State<info_page> {
  int companyName;
  _info_page(this.companyName);

  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  TextEditingController _contactText = TextEditingController();
  TextEditingController _telText = TextEditingController();
  TextEditingController _addressText = TextEditingController();
  String country;
  String province;
  String district;
  
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
                              this.companyName.toString(),
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
                              String tmp_country = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return country_page();
                              }));
                              setState(() {
                                country = tmp_country;
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
                              String tmp_province =
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                return province_page();
                              }));
                              setState(() {
                                province = tmp_province;
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
                              String tmp_district =
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                return district_page();
                              }));
                              setState(() {
                                district = tmp_district;
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
                Navigator.of(context).pop();
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
