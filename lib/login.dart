import 'dart:convert';

import 'package:animations/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  login(String username, password) async {
    auth(username, password).then((token) {
      if (token != null) {
        var res = tryParseJwt(token);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => Profile(
                  empId: res?["EmpId"],
                  centerID: res?["Centerid"],
                  name: res?[
                      "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"],
                  role: res?[
                      "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"])),
        );
      }
    });
  }

  Future<String?> auth(String username, password) async {
    String? token;
    // username = "uday.k@falconavl.com";
    // password = "3567Cpl&";
    try {
      var response = await http.post(
          Uri.parse("http://falconavl.com/tms/api/Auth/EmpWebLogin"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "userName": username,
            "password": password,
          }));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        token = data["webResource"]["token"];
      }
    } catch (e) {
      return null;
    }
    return token;
  }

  var userController = TextEditingController();
  var passwordConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0))),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: FlutterLogo(
                    size: 100,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 232, 232),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          controller: userController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            controller: passwordConroller,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter Your Password',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CupertinoButton(
                            color: const Color.fromARGB(255, 95, 184, 244),
                            borderRadius: BorderRadius.circular(30.0),
                            child: const Text("LOGIN"),
                            onPressed: () {
                              login(
                                  userController.text, passwordConroller.text);
                            }),
                      )
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
}

Map<String, dynamic>? tryParseJwt(String? token) {
  if (token == null) return null;
  final parts = token.split('.');
  if (parts.length != 3) {
    return null;
  }
  final payload = parts[1];
  var normalized = base64Url.normalize(payload);
  var resp = utf8.decode(base64Url.decode(normalized));
  final payloadMap = json.decode(resp);
  if (payloadMap is! Map<String, dynamic>) {
    return null;
  }
  return payloadMap;
}
