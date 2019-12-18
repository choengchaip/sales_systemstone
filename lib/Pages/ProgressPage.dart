import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'Components/StatusPage.dart';

class progress_page extends StatefulWidget {
  String companyId;
  String userId;
  progress_page(this.companyId, this.userId);
  @override
  _progress_page createState() => _progress_page(this.companyId, this.userId);
}

class _progress_page extends State<progress_page> {
  String companyId;
  String userId;
  _progress_page(this.companyId, this.userId);
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);
  String dateTime;
  String status;
  String status_id;
  String employee = "กำลังโหลด";
  List<dynamic> employees = ["กำลังโหลด"];
  String companyName;

  String hostIP = "localhost";
  String port = '8750';

  TextEditingController _noteText = TextEditingController();

  final format = DateFormat("yyyy-MM-dd HH:mm");
  final textAreaFocus = FocusNode();

  Future getCompanyName() async {
    var res = await http
        .get('http://${hostIP}:${port}/getCompanyName?companyId=${companyId}');
    setState(() {
      companyName = res.body;
    });
  }

  Future getEmployeeName() async {
    var res = await http.get('http://${hostIP}:${port}/getEmployeeName');
    var tmp_employees = [];
    var employeeJson = jsonDecode(res.body);
    for (int i = 0; i < employeeJson.length; i++) {
      tmp_employees.add(employeeJson[i]['SHORT_NAME']);
    }
    print(tmp_employees);
    setState(() {
      employee = tmp_employees[0];
      employees = tmp_employees;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompanyName();
    getEmployeeName();
  }

  Future updateCompanyProgress() async {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        });
    var res = await http
        .post('http://${hostIP}:${port}/updateCompanyProgress', body: {
      'datetime': dateTime,
      'status': status_id,
      'note': _noteText.text,
      'sale_name': employee,
      'created_by': userId,
      'companyName': companyName
    });
    Navigator.pop(context);
    var tmp = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("อัพเดทสำเร็จ"),
            actions: <Widget>[
              FlatButton(
                  child: Text("ตกลง"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
    Navigator.of(context).pop();
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
                              "วันที่บันทึก",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              final time = await showTimePicker(
                                context: context,
                                initialTime:
                                    TimeOfDay.fromDateTime(DateTime.now()),
                              );
                              setState(() {
                                dateTime = format
                                    .format(DateTimeField.combine(date, time))
                                    .toString();
                              });
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  // color: Colors.redAccent,
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      dateTime == null
                                          ? "กรุณาเลือกวันที่"
                                          : dateTime,
                                      style: headerDetial,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 4, bottom: 5),
                                    child: Image.asset(
                                        "assets/images/calendar.png"),
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
                              "สถานะ",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var tmp_status = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return status_page();
                              }));
                              setState(() {
                                if (tmp_status != null) {
                                  status = tmp_status['status_name'];
                                  status_id =
                                      tmp_status['status_id'].toString();
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
                                  Container(
                                    child: Text(
                                      status == null
                                          ? "กรุณาเลือกสถานะ"
                                          : status,
                                      style: headerDetial,
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 4, bottom: 5),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 17,
                                      )),
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
                              "ข้อความโน๊ต",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              textAreaFocus.requestFocus();
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              height: 163,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextField(
                                controller: _noteText,
                                focusNode: textAreaFocus,
                                maxLines: null,
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
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
                              "พนักงานขาย",
                              style: headerDetial,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: employee,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 24,
                                          ),
                                          underline: Container(
                                            height: 0,
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              employee = value;
                                            });
                                          },
                                          items: employees
                                              .map<DropdownMenuItem<String>>(
                                                  (dynamic value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: headerDetial,
                                              ),
                                            );
                                          }).toList()),
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
                print(dateTime);
                print(status_id);
                print(_noteText.text);
                print(employee);
                print(userId);
                updateCompanyProgress();
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
