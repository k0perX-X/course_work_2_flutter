import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/models/drug.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:course_work_2_flutter/hidden_values.dart' as hidden_values;
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class TakeMedicine extends StatefulWidget {
  const TakeMedicine(this.drug, this.remaining, {Key? key}) : super(key: key);

  final Drug drug;
  final int remaining;

  @override
  State<StatefulWidget> createState() => _TakeMedicine();
}

class _TakeMedicine extends State<TakeMedicine> {
  int _drugCounter = 1;

  void _incrementCounter() {
    if (_drugCounter < widget.remaining) {
      setState(() {
        _drugCounter++;
      });
    }
  }

  void _decrementCounter() {
    if (_drugCounter > 1) {
      setState(() {
        _drugCounter--;
      });
    }
  }

  Future<void> _saveButton(BuildContext context) async {
    void showErrorMessage() async {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                AppLocalizations.of(context)!.takeMedicineSaveErrorTitle),
            content: Text(
                AppLocalizations.of(context)!.takeMedicineSaveErrorNote),
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
    try {
      final url = Uri.http(
          hidden_values.serviceUrl,
          "TakeMedicine",
          {
            "drugId": widget.drug.id.toString(),
            'numberOfDoses': _drugCounter.toString()
          }
      );
      final response = await http.put(url,
          headers: {
            "Authorization": globals.settings.getString("token") ?? ""
          });
      bool json = jsonDecode(response.body);
      if (json) {
        Navigator.of(context).pop();
      } else {
        showErrorMessage();
      }
    }
    catch (e, s) {
      developer.log(e.toString());
      developer.log(s.toString());
      showErrorMessage();
    }
  }

  void _closeButton(BuildContext context){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Stack(children: [
                  Container(),
                  Container(
                      padding: const EdgeInsets.only(left: 0, top: 100),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.drug.name,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2),
                            Visibility(
                                visible: widget.drug.note?.isNotEmpty ?? false,
                                child: Text(
                                  widget.drug.note ?? "",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1,
                                )),
                          ])),
                  Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox.fromSize(
                              size: const Size(100, 100),
                              child: ClipOval(
                                child: Material(
                                  color: globals.accentColor,
                                  child: InkWell(
                                    onTap: _decrementCounter,
                                    child: const Icon(Icons.remove),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "$_drugCounter",
                              style: const TextStyle(fontSize: 100),
                            ),
                            SizedBox.fromSize(
                              size: const Size(100, 100),
                              child: ClipOval(
                                child: Material(
                                  color: globals.accentColor,
                                  child: InkWell(
                                    onTap: _incrementCounter,
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(AppLocalizations.of(context)!.takeMedicineDrugsRemaining
                          .replaceAll("{doses}", "${widget.remaining - _drugCounter}"),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: FloatingActionButton.extended(
                                    label: Text(
                                      AppLocalizations.of(context)!
                                          .takeMedicineSaveButton,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    backgroundColor: globals.accentColor,
                                    onPressed: () {
                                      _saveButton(context);
                                    },
                                  )),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: FloatingActionButton.extended(
                                    label: Text(
                                      AppLocalizations.of(context)!
                                          .takeMedicineCloseButton,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    backgroundColor: globals.accentColor,
                                    onPressed: () {_closeButton(context);},
                                  )),
                            ]),
                      ]))
                ]))));
  }
}
