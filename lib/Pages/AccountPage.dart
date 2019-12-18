import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class account_page extends StatefulWidget {
  String userId;
  account_page(this.userId);
  @override
  _account_page createState() => _account_page(this.userId);
}

class _account_page extends State<account_page> {
  String userId;
  _account_page(this.userId);

  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle logoutStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red);
  TextStyle headerDetial = TextStyle(fontSize: 18);
  String userName;

  String hostIP = "192.168.1.12";
  String port = "8750";

  Future getUserInfo() async {
    var res = await http
        .get('http://${hostIP}:${port}/getUserInfo?userId=${this.userId}');
    setState(() {
      userName = res.body;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
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
              "บัญชี",
              style: topStyle,
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "ชื่อผู้ใช้",
                            style: headerDetial,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            userName == null ? "กำลังโหลด" : userName,
                            style: companyStyle,
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
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("ต้องการออกจากระบบหรือไม่ ?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("ยกเลิก"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        FlatButton(
                          child: Text("ตกลง"),
                          onPressed: () =>
                              Navigator.of(context).popUntil((a) => a.isFirst),
                        )
                      ],
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1.5)]
              ),
              alignment: Alignment.center,
              child: Text("ออกจากระบบ", style: logoutStyle),
            ),
          ),
        ],
      ),
    );
  }
}
