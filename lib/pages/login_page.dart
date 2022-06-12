import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';
// import 'package:bcrypt/bcrypt.dart';
import 'package:course_work_2_flutter/hidden_values.dart' as hidden_values;
import 'dart:developer' as developer;
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:course_work_2_flutter/scripts/all_scripts.dart' as scripts;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String email = "";
  String password = "";

  void login() async {
    void showErrorMessage() async {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.loginErrorTitle),
            content: Text(AppLocalizations.of(context)!.loginErrorNote),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    var deviceInfoPlugin = DeviceInfoPlugin();
    var deviceInfo = await deviceInfoPlugin.deviceInfo;
    var map = deviceInfo.toMap();
    try {
      var r = await fetchResponse(email, password, map.toString());
      globals.settings.setString("name", r.name);
      globals.settings.setString("surname", r.surname);
      globals.settings.setString("middleName", r.middleName ?? "");
      globals.settings.setString("token", r.token);
      scripts.reloadApp(context);
    } on http.ClientException catch (e, s) {
      developer.log("login error - http.ClientException",
          error: e, stackTrace: s);
      showErrorMessage();
    } catch (e, s) {
      developer.log("login error - $e", error: e, stackTrace: s);
      showErrorMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: Text(
                AppLocalizations.of(context)!.loginWelcomeTitle,
                style: const TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String value) => email = value,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: const TextStyle(),
                            onChanged: (String value) => password = value,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.loginSingIn,
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: login,
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          // const SizedBox(
                          //   height: 40,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.pushNamed(context, 'register');
                          //       },
                          //       style: ButtonStyle(),
                          //       child: const Text(
                          //         'Sign Up',
                          //         textAlign: TextAlign.left,
                          //         style: TextStyle(
                          //             decoration: TextDecoration.underline,
                          //             color: Color(0xff4c505b),
                          //             fontSize: 18),
                          //       ),
                          //     ),
                          //     TextButton(
                          //         onPressed: () {},
                          //         child: const Text(
                          //           'Forgot Password',
                          //           style: TextStyle(
                          //             decoration: TextDecoration.underline,
                          //             color: Color(0xff4c505b),
                          //             fontSize: 18,
                          //           ),
                          //         )),
                          //   ],
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Response {
  // "token": "string",
  // "name": "string",
  // "surname": "string",
  // "middleName": "string"
  final String token;
  final String name;
  final String surname;
  final String? middleName;

  const Response(
      {required this.token,
      required this.name,
      required this.surname,
      required this.middleName});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        token: json['token'],
        name: json['name'],
        surname: json['surname'],
        middleName: json['middleName']);
  }
}

Future<Response> fetchResponse(
    String email, String password, String deviceInformation) async {
  final url = Uri.http(hidden_values.serviceUrl, "OAuth");
  final response = await http.post(
    url,
    headers: {
      "content-type": "application/json; charset=utf-8"
    },
    body: jsonEncode({
      "eMail": email,
      "password": password,
      "deviceInformation": deviceInformation
    })
  );
  if (response.statusCode == 200) {
    return Response.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 403) {
    throw ForbiddenException('Forbidden error');
  } else {
    throw Exception("Unknown error ${response.statusCode}");
  }
}

class ForbiddenException implements Exception {
  final String cause;

  ForbiddenException(this.cause);
}
