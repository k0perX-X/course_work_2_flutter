import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/models/drug.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:course_work_2_flutter/hidden_values.dart' as hidden_values;
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine(this._drugs, {Key? key, this.restorationId})
      : super(key: key);
  final List<Drug> _drugs;
  final String? restorationId;

  @override
  State<StatefulWidget> createState() => _AddMedicine();

  static Future<List<Drug>> getDrugs() async {
    final url = Uri.http(hidden_values.serviceUrl, "AllDrugs");
    final response = await http.get(
      url,
      headers: {"Authorization": globals.settings.getString("token") ?? ""},
    );
    return (jsonDecode(response.body) as List<dynamic>)
        .map((el) => Drug.fromJson(el))
        .toList();
  }
}

class _AddMedicine extends State<AddMedicine> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  int _drugCounter = 1;
  late Drug _drug;

  @override
  void initState() {
    super.initState();
    _drug = widget._drugs[0];
  }

  void _incrementCounter() {
    setState(() {
      _drugCounter++;
    });
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
            title:
                Text(AppLocalizations.of(context)!.addMedicineSaveErrorTitle),
            content:
                Text(AppLocalizations.of(context)!.addMedicineSaveErrorNote),
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
      final url = Uri.http(hidden_values.serviceUrl, "PatientDrugsRemaining");
      final response = await http.post(
        url,
        headers: {
          "Authorization": globals.settings.getString("token") ?? "",
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "id": _drug.id,
          "dateOfManufacture": _selectedDate.value.toIso8601String(),
          "remaining": _drugCounter
        }),
      );
      jsonDecode(response.body);
      Navigator.of(context).pop();
    } catch (e, s) {
      dev.log(e.toString());
      dev.log(s.toString());
      showErrorMessage();
    }
  }

  void _closeButton(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _changeDrug(Drug? data) {
    if (data != null) {
      setState(() {
        _drug = data;
      });
    }
  }

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Selected: ${DateFormat.yMd().format(_selectedDate.value)}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.addMedicineTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 10),
              DropdownSearch<Drug>(
                asyncItems: (String filter) async => widget._drugs
                    .where((element) => element.name == filter)
                    .toList(),
                itemAsString: (Drug u) => u.name,
                onChanged: _changeDrug,
                items: widget._drugs,
                selectedItem: _drug,
                popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                  isFilterOnline: true,
                  showSelectedItems: false,
                  showSearchBox: true,
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: _drug.note?.isNotEmpty ?? false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _drug.note ?? "",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!
                      .addMedicineEnterDateOfManuf),
                  OutlinedButton(
                    onPressed: () {
                      _restorableDatePickerRouteFuture.present();
                    },
                    child: Text(DateFormat.yMd().format(_selectedDate.value)),
                  ),
                ],
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FloatingActionButton.extended(
                        label: Text(
                          AppLocalizations.of(context)!.takeMedicineSaveButton,
                          style: Theme.of(context)
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FloatingActionButton.extended(
                      label: Text(
                        AppLocalizations.of(context)!.takeMedicineCloseButton,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      backgroundColor: globals.accentColor,
                      onPressed: () {
                        _closeButton(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
