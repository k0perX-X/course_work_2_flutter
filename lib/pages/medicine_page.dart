import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/widgets/application_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:course_work_2_flutter/hidden_values.dart' as hidden_values;
import 'package:http/http.dart' as http;
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:course_work_2_flutter/models/drug.dart';
import 'package:course_work_2_flutter/pages/take_medicine.dart';
import 'package:course_work_2_flutter/widgets/better_list_view.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MedicinePage();
}

class _MedicinePage extends State<MedicinePage> {
  Future<Widget> getAllData(BuildContext context) async {
    Future<void> functionOnTap(
        BuildContext context, Drug drug, int remaining) async {
      await Navigator.push(
          context,
          MaterialPageRoute<bool>(
              builder: (context) => TakeMedicine(drug, remaining)));
      setState(() {});
    }

    var responses = await Future.wait([
      getRunningOutMedications(),
      getPatientPrescribedMedications(),
      getPatientMedicineWillGoBad(),
      getPatientDrugsRemaining()
    ]);

    List<RunningOutMedication> runningOutMedications =
        responses[0] as List<RunningOutMedication>;
    List<PatientPrescribedMedication> patientPrescribedMedications =
        responses[1] as List<PatientPrescribedMedication>;
    List<PatientDrugRemaining> patientMedicineWillGoBad =
        responses[2] as List<PatientDrugRemaining>;
    List<PatientDrugRemaining> patientDrugsRemaining =
        responses[3] as List<PatientDrugRemaining>;

    // var runningOutMedications = await getRunningOutMedications();
    // var patientPrescribedMedications = await getPatientPrescribedMedications();
    // var patientMedicineWillGoBad = await getPatientMedicineWillGoBad();
    // var patientDrugsRemaining = await getPatientDrugsRemaining();

    var drugMap = <int, DrugMap>{};
    for (var r in runningOutMedications) {
      if (!drugMap.containsKey(r.drug.id)) {
        drugMap[r.drug.id] = DrugMap();
      }
      drugMap[r.drug.id]!.runningOutMedication = r;
    }
    for (var r in patientPrescribedMedications) {
      if (!drugMap.containsKey(r.drug.id)) {
        drugMap[r.drug.id] = DrugMap();
      }
      drugMap[r.drug.id]!.patientPrescribedMedication = r;
    }
    for (var r in patientDrugsRemaining) {
      if (!drugMap.containsKey(r.drug.id)) {
        drugMap[r.drug.id] = DrugMap();
      }
      drugMap[r.drug.id]!.patientDrugRemaining = r;
    }

    List<Widget> listPatientMedicineWillGoBad = patientMedicineWillGoBad.map((v) {
      return ElevatedButton(
        onPressed: () async {
          functionOnTap(context, v.drug, v.remaining);
        },
        child: Row(children: [
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: v.drug.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.red),
            ),
            const TextSpan(text: "\n"),
            TextSpan(
              text: AppLocalizations.of(context)!
                  .medicineWillGoBad
                  .replaceAll("{remaining}", v.remaining.toString())
                  .replaceAll('{date}', v.minimalDateOfManufacture.toString()),
              style: const TextStyle(color: Colors.red),
            ),
          ])),
        ]),
        // ListTile(
        //   title: Text(
        //     patientMedicineWillGoBad[index].drug.name,
        //     style: const TextStyle(color: Colors.red),
        //   ),
        // ))
      );
    }).toList();

    var listPrescribedMedicationsWarns = <DrugMap>[];
    var listPrescribedMedicationsNotWarns = <DrugMap>[];
    drugMap.forEach((k, v) {
      if (v.runningOutMedication != null) {
        listPrescribedMedicationsWarns.add(v);
      } else {
        listPrescribedMedicationsNotWarns.add(v);
      }
    });

    List<Widget> listPrescribedMedicationsWarnsWidgets =
        listPrescribedMedicationsWarns.map((v) {
      var time = [
        v.patientPrescribedMedication!.receptionTimeInTheMorning
            ? AppLocalizations.of(context)!.medicineReceptionTimeInTheMorning
            : "",
        v.patientPrescribedMedication!.receptionTimeDuringTheDay
            ? AppLocalizations.of(context)!.medicineReceptionTimeDuringTheDay
            : "",
        v.patientPrescribedMedication!.receptionTimeInTheEvening
            ? AppLocalizations.of(context)!.medicineReceptionTimeInTheEvening
            : "",
      ];
      time.removeWhere((element) => element == "");
      return ElevatedButton(
          onPressed: () async {
            var remaining = v.runningOutMedication!.remaining;
            if (remaining > 0) {
              await functionOnTap(
                  context, v.runningOutMedication!.drug, remaining);
            } else {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!
                        .medicineTakeRunningOutMedicationErrorTitle),
                    content: Text(AppLocalizations.of(context)!
                        .medicineTakeRunningOutMedicationErrorNote),
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
          },
          child: Row(children: [
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: v.runningOutMedication!.drug.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const TextSpan(text: "\n"),
              TextSpan(
                text: AppLocalizations.of(context)!
                    .medicineInstruction
                    .replaceAll("{time}", time.join(", "))
                    .replaceAll(
                        "{meals}",
                        [
                          v.patientPrescribedMedication!.takeBeforeMeals
                              ? AppLocalizations.of(context)!
                                  .medicineTakeBeforeMeals
                              : "",
                          v.patientPrescribedMedication!.takeWithMeals
                              ? AppLocalizations.of(context)!
                                  .medicineTakeWithMeals
                              : "",
                          v.patientPrescribedMedication!.takeAfterMeals
                              ? AppLocalizations.of(context)!
                                  .medicineTakeAfterMeals
                              : "",
                        ].firstWhere((element) => element != "",
                            orElse: () => "")),
              ),
              const TextSpan(text: "\n"),
              TextSpan(
                text: AppLocalizations.of(context)!
                    .medicineRunningOutMedication
                    .replaceAll("{remaining}",
                        v.runningOutMedication!.remaining.toString())
                    .replaceAll('{leftToTake}',
                        v.runningOutMedication!.leftToTake.toString()),
                style: const TextStyle(color: Colors.red),
              ),
            ])),
          ]));
    }).toList();

    List<Widget> listPrescribedMedicationsNotWarnsWidgets =
        listPrescribedMedicationsNotWarns.map((v) {
      var time = [
        v.patientPrescribedMedication!.receptionTimeInTheMorning
            ? AppLocalizations.of(context)!.medicineReceptionTimeInTheMorning
            : "",
        v.patientPrescribedMedication!.receptionTimeDuringTheDay
            ? AppLocalizations.of(context)!.medicineReceptionTimeDuringTheDay
            : "",
        v.patientPrescribedMedication!.receptionTimeInTheEvening
            ? AppLocalizations.of(context)!.medicineReceptionTimeInTheEvening
            : "",
      ];
      time.removeWhere((element) => element == "");
      return ElevatedButton(
          onPressed: () async {
            functionOnTap(context, v.patientDrugRemaining!.drug,
                v.patientDrugRemaining!.remaining);
          },
          child: Row(children: [
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: v.patientDrugRemaining!.drug.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const TextSpan(text: "\n"),
              TextSpan(
                text: AppLocalizations.of(context)!
                    .medicineInstruction
                    .replaceAll("{time}", time.join(", "))
                    .replaceAll(
                        "{meals}",
                        [
                          v.patientPrescribedMedication!.takeBeforeMeals
                              ? AppLocalizations.of(context)!
                                  .medicineTakeBeforeMeals
                              : "",
                          v.patientPrescribedMedication!.takeWithMeals
                              ? AppLocalizations.of(context)!
                                  .medicineTakeWithMeals
                              : "",
                          v.patientPrescribedMedication!.takeAfterMeals
                              ? AppLocalizations.of(context)!
                                  .medicineTakeAfterMeals
                              : "",
                        ].firstWhere((element) => element != "",
                            orElse: () => "")),
              ),
            ]))
          ]));
    }).toList();

    return BetterListView(listPatientMedicineWillGoBad +
        listPrescribedMedicationsWarnsWidgets +
        listPrescribedMedicationsNotWarnsWidgets);
  }

  @override
  Widget build(BuildContext context) {
    // var titleStyle =
    // Theme
    //     .of(context)
    //     .textTheme
    //     .bodyText1!
    //     .copyWith(color: Colors.white);
    return ListView(
      children: [
        FutureBuilder<Widget>(
            future: getAllData(context),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[snapshot.data!];
              } else if (snapshot.hasError) {
                var e = snapshot.error;
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child:
                        Text(AppLocalizations.of(context)!.medicineLoadError),
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
                    child: Text(AppLocalizations.of(context)!.medicineLoading),
                  )
                ];
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              );
            }),
      ],
    );
  }
}

class DrugMap {
  RunningOutMedication? runningOutMedication;
  PatientPrescribedMedication? patientPrescribedMedication;
  PatientDrugRemaining? patientDrugRemaining;
}

class RunningOutMedication {
  final int remaining;
  final int leftToTake;
  final Drug drug;

  RunningOutMedication(this.remaining, this.leftToTake, this.drug);

  factory RunningOutMedication.fromJson(Map<String, dynamic> json) {
    return RunningOutMedication(
        json["remaining"], json["leftToTake"], Drug.fromJson(json["drug"]));
  }
}

class PatientPrescribedMedication {
  final Drug drug;
  final bool receptionTimeInTheMorning;
  final bool receptionTimeDuringTheDay;
  final bool receptionTimeInTheEvening;
  final bool takeBeforeMeals;
  final bool takeAfterMeals;
  final bool takeWithMeals;

  PatientPrescribedMedication(
      this.drug,
      this.receptionTimeInTheMorning,
      this.receptionTimeDuringTheDay,
      this.receptionTimeInTheEvening,
      this.takeBeforeMeals,
      this.takeWithMeals,
      this.takeAfterMeals);

  factory PatientPrescribedMedication.fromJson(Map<String, dynamic> json) {
    return PatientPrescribedMedication(
        Drug.fromJson(json["drug"]),
        json["receptionTimeInTheMorning"],
        json["receptionTimeDuringTheDay"],
        json["receptionTimeInTheEvening"],
        json["takeBeforeMeals"],
        json["takeWithMeals"],
        json["takeAfterMeals"]);
  }
}

class PatientDrugRemaining {
  final Drug drug;
  final DateTime minimalDateOfManufacture;
  final int remaining;

  PatientDrugRemaining(
      this.drug, this.minimalDateOfManufacture, this.remaining);

  factory PatientDrugRemaining.fromJson(Map<String, dynamic> json) {
    return PatientDrugRemaining(Drug.fromJson(json["drug"]),
        json["minimalDateOfManufacture"], json["remaining"]);
  }
}

Future<List<PatientDrugRemaining>> getPatientDrugsRemaining() async {
  final url = Uri.http(
    hidden_values.serviceUrl,
    "PatientDrugsRemaining",
  );
  final response = await http.get(url,
      headers: {"Authorization": globals.settings.getString("token") ?? ""});
  List<dynamic> json = jsonDecode(response.body);
  if (json.isEmpty) {
    return [];
  } else {
    return List<PatientDrugRemaining>.generate(
        json.length, (index) => PatientDrugRemaining.fromJson(json[index]));
  }
}

Future<List<PatientDrugRemaining>> getPatientMedicineWillGoBad() async {
  final url = Uri.http(hidden_values.serviceUrl, "PatientMedicineWillGoBad", {
    "beforeDate": DateTime.now().add(const Duration(days: 30)).toIso8601String()
  });
  final response = await http.get(url,
      headers: {"Authorization": globals.settings.getString("token") ?? ""});
  List<dynamic> json = jsonDecode(response.body);
  if (json.isEmpty) {
    return [];
  } else {
    return List<PatientDrugRemaining>.generate(
        json.length, (index) => PatientDrugRemaining.fromJson(json[index]));
  }
}

Future<List<PatientPrescribedMedication>>
    getPatientPrescribedMedications() async {
  final url = Uri.http(
    hidden_values.serviceUrl,
    "PatientPrescribedMedications",
  );
  final response = await http.get(url,
      headers: {"Authorization": globals.settings.getString("token") ?? ""});
  List<dynamic> json = jsonDecode(response.body);
  if (json.isEmpty) {
    return [];
  } else {
    return List<PatientPrescribedMedication>.generate(json.length,
        (index) => PatientPrescribedMedication.fromJson(json[index]));
  }
}

Future<List<RunningOutMedication>> getRunningOutMedications(
    // BuildContext context, TextStyle textStyle,
    // {Function(BuildContext, int)? functionOnTap}
    ) async {
  final url = Uri.http(
    hidden_values.serviceUrl,
    "RunningOutMedications",
  );
  final response = await http.get(url,
      headers: {"Authorization": globals.settings.getString("token") ?? ""});
  List<dynamic> json = jsonDecode(response.body);
  if (json.isEmpty) {
    return [
      // TextLine(
      //     AppLocalizations.of(context)!
      //         .medicineRunningOutMedication
      //         .replaceAll("{drugname}", "test")
      //         .replaceAll("{remaining}", "10")
      //         .replaceAll('{leftToTake}', "20"),
      //     functionOnTap ??
      //         (context, i) {
      //           Navigator.of(context).push(MaterialPageRoute<void>(
      //               builder: (context) =>
      //                   TakeMedicine(Drug(1, "test", note: "testing"), 10)));
      //
      //         },
      //     textStyle)
    ];
  }
  return List<RunningOutMedication>.generate(json.length, (index) {
    return RunningOutMedication.fromJson(json[index]);
  });
  //   return TextLine(
  //       AppLocalizations.of(context)!
  //           .medicineRunningOutMedication
  //           .replaceAll("{drugname}", p.drug.name)
  //           .replaceAll("{remaining}", p.remaining.toString())
  //           .replaceAll('{leftToTake}', p.leftToTake.toString()),
  //       functionOnTap ??
  //           (context, i) {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute<bool>(
  //                     builder: (context) => TakeMedicine(p.drug, p.remaining)));
  //           },
  //       textStyle);
  // });
}
