import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/widgets/application_section.dart';
import 'package:course_work_2_flutter/hidden_values.dart' as hidden_values;
import 'package:http/http.dart' as http;
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as dev;

class HealthStatus extends StatefulWidget {
  const HealthStatus({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HealthStatus();
}

class _HealthStatus extends State {
  double _currentSliderValue = 36.6;
  final _text = TextEditingController();

  Future<void> postWellBeingRecord() async {
    final url = Uri.http(hidden_values.serviceUrl, "PatientWellBeingRecord");
    var body = jsonEncode({
      'temperature': _currentSliderValue,
      'note': _text.text,
    });
    if (!((_currentSliderValue == 36.6) && (_text.text == ""))) {
      final response = await http.post(url,
        headers: {
          "Authorization": globals.settings.getString("token") ?? "",
          "content-type": "application/json; charset=utf-8"
        },
        body: body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
          await postWellBeingRecord();
        },
        backgroundColor: globals.accentColor,
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Text(
                AppLocalizations.of(context)!.healthStatusTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.healthStatusTemperature,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Slider(
                value: _currentSliderValue,
                max: 40,
                min: 34,
                divisions: 60,
                thumbColor: globals.accentColor,
                activeColor: globals.accentColor,
                inactiveColor: globals.dimAccentColor,
                label: _currentSliderValue.toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              Text(
                AppLocalizations.of(context)!.healthStatusNote,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: _text,
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
