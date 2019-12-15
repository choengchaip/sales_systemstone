import 'package:flutter/material.dart';

class prospect_page extends StatefulWidget {
  String companyName;
  prospect_page(this.companyName);
  @override
  _prospect_page createState() => _prospect_page(this.companyName);
}

class _prospect_page extends State<prospect_page> {
  String companyName;
  _prospect_page(this.companyName);

  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);

  TextEditingController _moneyText = TextEditingController();

  String stringToMoney(String money){
    //1000000000
    String moneyValue = "";
    int count =0;
    for(int i=money.length-1;i>=0;i--){
      if(count%3 == 0 && count!=0){
        moneyValue += ',';
      }
      moneyValue += money[i];
      count++;
    }
    String realMoney = "";
    for(int i=moneyValue.length-1;i>=0;i--){
      realMoney += moneyValue[i];
    }
    return realMoney;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                              this.companyName,
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
                                      onChanged: (String money){
                                        setState(() {
                                          _moneyText.text = stringToMoney(money);
                                        });
                                      },
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
                              "สถานะ",
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
                                  Container(
                                    child: Text(
                                      "sad",
                                      style: headerDetial,
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
