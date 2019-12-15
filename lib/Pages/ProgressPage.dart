import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'Components/StatusPage.dart';

class progress_page extends StatefulWidget {
  String companyName;
  progress_page(this.companyName);
  @override
  _progress_page createState() => _progress_page(this.companyName);
}

class _progress_page extends State<progress_page> {
  String companyName;
  _progress_page(this.companyName);
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle headerDetial = TextStyle(fontSize: 18);
  String dateTime;
  String status;
  String employee = "เกว";

  final format = DateFormat("yyyy-MM-dd HH:mm");

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
                              String tmp_status = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return status_page();
                              }));
                              setState(() {
                                status = tmp_status;
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
                            onTap: () {},
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
                                          items: <String>[
                                            'เกว',
                                            'สิงห์',
                                            'พี่เอก'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
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
