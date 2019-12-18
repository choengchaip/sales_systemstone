import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class prospect_page extends StatefulWidget {
  String companyId;
  String userId;
  prospect_page(this.companyId, this.userId);
  @override
  _prospect_page createState() => _prospect_page(this.companyId, this.userId);
}

class _prospect_page extends State<prospect_page> {
  String companyId;
  String userId;
  _prospect_page(this.companyId, this.userId);

  String hostIP = "192.168.1.12";
  String port = '8750';
  String companyName;

  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  TextEditingController _moneyText = TextEditingController();
  TextEditingController _prosText = TextEditingController();

  Future getCompanyName() async {
    var res = await http
        .get('http://${hostIP}:${port}/getCompanyName?companyId=${companyId}');
    setState(() {
      companyName = res.body;
    });
  }

  String stringToMoney(String money) {
    //1000000000
    String moneyValue = "";
    int count = 0;
    for (int i = money.length - 1; i >= 0; i--) {
      if (money[i] == ',') {
        continue;
      }
      if (count % 3 == 0 && count != 0) {
        moneyValue += ',';
      }
      moneyValue += money[i];
      count++;
    }
    String realMoney = "";
    for (int i = moneyValue.length - 1; i >= 0; i--) {
      realMoney += moneyValue[i];
    }
    return realMoney;
  }

  Future<bool> updateCompanyProspect() async {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        });

    String money = "";
    for (int i = 0; i < _moneyText.text.length; i++) {
      if (_moneyText.text[i] == ',') {
        continue;
      }
      money += _moneyText.text[i];
    }

    if (money.isEmpty) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("กรุณาใส่ยอดขาย"),
              actions: <Widget>[
                FlatButton(
                  child: Text("ตกลง"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return false;
    }

    if (_prosText.text.isEmpty) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("กรุณาใส่ความเป็นไปได้"),
              actions: <Widget>[
                FlatButton(
                  child: Text("ตกลง"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return false;
    }

    var res = await http
        .post('http://${hostIP}:${port}/updateCompanyProspect', body: {
      'userId': this.userId,
      'companyId': this.companyId,
      'dealPercent': _prosText.text,
      'expectedRev': money
    });
    if (res.body == '1') {
      Navigator.of(context).pop();
      var a = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("บันทึกสำเร็จแล้ว"),
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
      return true;
    } else {
      Navigator.of(context).pop();
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
                      "บันทึกความคืบหน้า",
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
                              "ยอดขาย",
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
                                      controller: _moneyText,
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
                              "% ที่คาดว่าปิดได้",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
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
                                      child: TextField(
                                        controller: _prosText,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration.collapsed(
                                            hintText: ""),
                                        style: headerDetial,
                                      ),
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
                updateCompanyProspect();
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
