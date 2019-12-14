import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Pages/CompanyPage.dart';

class login_page extends StatefulWidget {
  @override
  _login_page createState() => _login_page();
}

class _login_page extends State<login_page> {
  TextStyle loginStyle = TextStyle(fontSize: 18, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/logo.png"),
              height: 80,
              margin: EdgeInsets.only(bottom: 15),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Color(0xffB2B2B2)),
              ),
              height: 41,
              width: 251,
              margin: EdgeInsets.only(bottom: 15),
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: "ชื่อผู้ใช้"),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Color(0xffB2B2B2)),
              ),
              height: 41,
              width: 251,
              margin: EdgeInsets.only(bottom: 25),
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: "รหัสผ่าน"),
              ),
            ),
            Container(
              height: 1,
              width: 194,
              color: Color(0xffB2B2B2),
              margin: EdgeInsets.only(bottom: 25),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return company_page();
                }));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xff3D73BC)),
                height: 41,
                width: 251,
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "เข้าสู่ระบบ",
                  style: loginStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
