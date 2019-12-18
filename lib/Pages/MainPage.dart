import 'dart:convert';
import 'package:flutter/material.dart';
import 'AccountPage.dart';
import 'CompanyPage.dart';
import 'ProspectPage.dart';
import 'ProgressPage.dart';
import 'InfomationPage.dart';
import 'package:http/http.dart' as http;

class main_page extends StatefulWidget {
  String userId;
  main_page(this.userId);
  @override
  _main_page createState() => _main_page(this.userId);
}

class _main_page extends State<main_page> {
  String userId;
  _main_page(this.userId);
  TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20);
  TextStyle companyStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextEditingController _companyName = TextEditingController();
  List<dynamic> companyData;

  String hostIP = "192.168.1.12";
  String port = '8750';

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [company_page(this.userId),account_page(this.userId)];
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int _newPage){
          setState(() {
            currentPage = _newPage;
          });
        },
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("หน้าแรก")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("บัญชี")
          ),
        ],
      ),
    );
  }
}
