import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/widgets/application_section.dart';
import 'package:course_work_2_flutter/hidden_values.dart' as hidden_values;
import 'package:http/http.dart' as http;
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:course_work_2_flutter/pages/health_status_page.dart';

const procedureDuration = Duration(days: 14);

class PatientProcedure {
  DateTime dateTime;
  Procedure procedure;
  String? note;

  PatientProcedure(this.dateTime, this.procedure, this.note);

  factory PatientProcedure.fromJson(Map<String, dynamic> json) {
    return PatientProcedure(
        DateTime.parse(json["dateTime"]),
        Procedure(json["procedure"]["id"], json["procedure"]["name"],
            json["procedure"]["note"]),
        json["note"]);
  }

  String toStringContext(BuildContext context) {
    return AppLocalizations.of(context)!
        .homePatientProcedureToString
        .replaceAll("{date}", dateTime.toString())
        .replaceAll("{procedureName}", procedure.name)
        .replaceAll("{nl}", procedure.note == null ? "" : "\n")
        .replaceAll("{procedureNote}", procedure.note ?? "");
  }
}

class Procedure {
  int id;
  String name;
  String? note;

  Procedure(this.id, this.name, this.note);
}

class PatientDoctorsAppointment {
  DateTime dateTime;
  Doctor doctor;
  String? note;

  PatientDoctorsAppointment(this.dateTime, this.doctor, this.note);

  factory PatientDoctorsAppointment.fromJson(Map<String, dynamic> json) {
    return PatientDoctorsAppointment(
        DateTime.parse(json["dateTime"]),
        Doctor(
            json["doctor"]["id"],
            json["doctor"]["name"],
            json["doctor"]["surname"],
            json["doctor"]["middleName"],
            json["doctor"]["note"]),
        json["note"]);
  }

  String toStringContext(BuildContext context) {
    return AppLocalizations.of(context)!
        .homePatientDoctorsAppointmentToString
        .replaceAll("{date}", DateFormat.yMd().add_Hm().format(dateTime))
        .replaceAll("{doctorName}", doctor.name)
        .replaceAll("{doctorSurname}", doctor.surname)
        .replaceAll("{doctorMiddleName}", doctor.middleName ?? "")
        .replaceAll("{nl}", doctor.note == null ? "" : "\n")
        .replaceAll("{doctorNote}", doctor.note ?? "");
  }
}

class Doctor {
  int id;
  String name;
  String surname;
  String? middleName;
  String? note;

  Doctor(this.id, this.name, this.surname, this.middleName, this.note);
}

Future<List<TextLine>> getProcedures(BuildContext context, TextStyle textStyle,
    {Function(BuildContext, int)? functionOnTap}) async {
  final url = Uri.http(hidden_values.serviceUrl, "PatientProcedures",
      {"beforeDate": DateTime.now().add(procedureDuration).toIso8601String()});
  final response = await http.get(url,
      headers: {"Authorization": globals.settings.getString("token") ?? ""});
  List<dynamic> json = jsonDecode(response.body);
  if (json.isEmpty) {
    return [
      TextLine(
          AppLocalizations.of(context)!.homePatientProcedureZeroElementLoaded,
          functionOnTap ?? (context, i) {},
          textStyle)
    ];
  }
  return List<TextLine>.generate(json.length, (index) {
    var p = PatientProcedure.fromJson(json[index]);
    return TextLine(p.toStringContext(context),
        functionOnTap ?? (context, i) {}, textStyle);
  });
}

Future<List<TextLine>> getDoctorsAppointment(
    BuildContext context, TextStyle textStyle,
    {Function(BuildContext, int)? functionOnTap}) async {
  final url = Uri.http(hidden_values.serviceUrl, "PatientDoctorsAppointment",
      {"beforeDate": DateTime.now().add(procedureDuration).toIso8601String()});
  final response = await http.get(url,
      headers: {"Authorization": globals.settings.getString("token") ?? ""});
  List<dynamic> json = jsonDecode(response.body);
  if (json.isEmpty) {
    return [
      TextLine(
          AppLocalizations.of(context)!
              .homePatientDoctorsAppointmentZeroElementLoaded,
          functionOnTap ?? (c, i) {},
          textStyle)
    ];
  }
  return List<TextLine>.generate(json.length, (index) {
    var p = PatientDoctorsAppointment.fromJson(json[index]);
    return TextLine(
        p.toStringContext(context), functionOnTap ?? (c, i) {}, textStyle);
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white);
    return ListView(children: [
      //процедуры
      FutureBuilder<List<TextLine>>(
          future:
              getProcedures(context, Theme.of(context).textTheme.bodyText1!),
          builder:
              (BuildContext context, AsyncSnapshot<List<TextLine>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                ApplicationSection(
                    AppLocalizations.of(context)!.homePatientProcedureTitle,
                    titleStyle,
                    snapshot.data!)
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  // child: Text(snapshot.error.toString()),
                  child: Text(AppLocalizations.of(context)!
                      .homePatientProcedureLoadingError),
                )
              ];
            } else {
              children = <Widget>[
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(AppLocalizations.of(context)!
                      .homePatientProcedureLoading),
                )
              ];
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            );
          }),
      //Доктор
      FutureBuilder<List<TextLine>>(
          future: getDoctorsAppointment(
              context, Theme.of(context).textTheme.bodyText1!),
          builder:
              (BuildContext context, AsyncSnapshot<List<TextLine>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                ApplicationSection(
                    AppLocalizations.of(context)!
                        .homePatientDoctorsAppointmentTitle,
                    titleStyle,
                    snapshot.data!)
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  // child: Text(snapshot.error.toString()),
                  child: Text(AppLocalizations.of(context)!
                      .homePatientDoctorsAppointmentLoadingError),
                )
              ];
            } else {
              children = <Widget>[
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(AppLocalizations.of(context)!
                      .homePatientDoctorsAppointmentLoading),
                )
              ];
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            );
          }),
      Padding(
        padding: const EdgeInsets.all(15),
        child: FloatingActionButton.extended(
          label: Text(
            AppLocalizations.of(context)!.homeHealthStatusButton,
            style: TextStyle(color: globals.textOnAccent),
          ),
          backgroundColor: globals.accentColor,
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HealthStatus()));
          },
        ),
      ),
    ]);
  }
}
