import 'package:design/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  final resetpwd = TextEditingController();
  final confirmpwd = TextEditingController();
  late bool newuser;

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  @override
  void initState() {
    check_if_already_login();
    super.initState();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Mypage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF96D8E3), Color(0xFF35B4C9)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: const Center(
                child: Text(
                  "LOG",
                  style: TextStyle(fontSize: 80, color: Colors.white),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF288994), Color(0xFF06333B)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: username_controller,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email,
                              color: Color(0xFF288994),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: 'username',
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        controller: password_controller,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color(0xFF288994),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: 'Password',
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        child: TextButton(
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(color: Colors.teal[900]),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Column(
                                        children: [
                                          Text("Reset password"),
                                          // TextField(
                                          //   decoration: InputDecoration(
                                          //       hintText: " Username"),
                                          // ),
                                          TextField(
                                              controller: resetpwd,
                                              decoration: InputDecoration(
                                                  hintText: "New password")),
                                          TextField(
                                              controller: confirmpwd,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Confirm password")),
                                          TextButton(
                                              onPressed: () {
                                                restpassword();
                                              },
                                              child: Text("Submit"))
                                        ],
                                      ),
                                    ));
                          },
                        ))),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {
                                String username = username_controller.text;
                                String password = password_controller.text;
                                if (username != '' && password != '') {
                                  print('Successfull');
                                  logindata.setBool('login', false);
                                  logindata.setString('username', username);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mypage()));
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Log-In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF288994),
                                    Color(0xFF06333B)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  restpassword() {
    final newdata = resetpwd.text;
    final updata = confirmpwd.text;
    if (newdata == updata) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Mypage()));
    } else {
      print("invalid data");
    }
  }
}
