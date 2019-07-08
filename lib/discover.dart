import 'package:flutter/material.dart';
import 'memont.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.blue, Colors.blueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text("发现"),
      ),
      body: Container(
        color: Colors.black12,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                dense: true,
                leading: Icon(Icons.dialpad),
                title: Text(
                  "发现",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: new Icon(Icons.keyboard_arrow_right),
                contentPadding: EdgeInsets.only(right: 10, left: 15),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return MomentPage();
                  }));
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_other),
            title: Text("发现"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_other),
            title: Text("发现"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove),
            title: Text("发现"),
          ),
        ],
      ),
    );
  }
}
