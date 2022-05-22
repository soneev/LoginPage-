import 'package:flutter/material.dart';
import 'package:design/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lottie/lottie.dart';

class Mypage extends StatelessWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myapp',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key}) : super(key: key);

  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late SharedPreferences logindata;
  late String? username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 500,
              width: 700,
              child: Lottie.network(
                  "https://assets5.lottiefiles.com/packages/lf20_g8iumlrs.json"),
            ),
            Center(
              child: Text(
                'Welcome  $username',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              splashColor: Colors.amber,
              color: Color(0xFF288994),
              onPressed: () {
                logindata.setBool('login', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: Text('LogOut'),
            )
          ],
        ),
      ),
    );
  }
}
