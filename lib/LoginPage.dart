import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'Pages/CompanyPage.dart';
import 'package:http/http.dart' as http;

class login_page extends StatefulWidget {
  @override
  _login_page createState() => _login_page();
}

String hostIP = "localhost";
String port = '8750';

class _login_page extends State<login_page> {
  TextStyle loginStyle = TextStyle(fontSize: 18, color: Colors.white);

  TextEditingController _usernameText = TextEditingController();
  TextEditingController _passwordText = TextEditingController();

  String userId;

  Future<bool> sendLoginRequest() async {

    showDialog(
      context: context,
      builder: (context){
        return Container(
          height: 200,
          width: 300,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      }
    );

    var req = await http.post('http://${hostIP}:${port}/auth', body: {
      'username': _usernameText.text.toString(),
      'password': _passwordText.text.toString()
    });
    String res = req.body;
    print(res);
    if (res == '0') {
      return false;
    } else {
      setState(() {
        userId = res;
      });
      return true;
    }
  }

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
                controller: _usernameText,
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
                controller: _passwordText,
                keyboardType: TextInputType.text,
                obscureText: true,
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
              onTap: () async {
                bool status = await sendLoginRequest();
                if (status) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return company_page(userId);
                  }));
                }else{
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"),
                        actions: <Widget>[
                          FlatButton(child: Text("ตกลง"),onPressed: (){Navigator.of(context).pop();Navigator.of(context).pop();},)
                        ],
                      );
                    }
                  );
                }
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
