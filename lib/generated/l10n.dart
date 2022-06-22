// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select a production date:`
  String get addMedicineEnterDateOfManuf {
    return Intl.message(
      'Select a production date:',
      name: 'addMedicineEnterDateOfManuf',
      desc: '',
      args: [],
    );
  }

  /// `Save error. If the error persists, please try again later.`
  String get addMedicineSaveErrorNote {
    return Intl.message(
      'Save error. If the error persists, please try again later.',
      name: 'addMedicineSaveErrorNote',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get addMedicineSaveErrorTitle {
    return Intl.message(
      'Error',
      name: 'addMedicineSaveErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add medication`
  String get addMedicineTitle {
    return Intl.message(
      'Add medication',
      name: 'addMedicineTitle',
      desc: '',
      args: [],
    );
  }

  /// `Patient Application`
  String get appTitle {
    return Intl.message(
      'Patient Application',
      name: 'appTitle',
      desc: 'Название приложения',
      args: [],
    );
  }

  /// `Describe your condition`
  String get healthStatusNote {
    return Intl.message(
      'Describe your condition',
      name: 'healthStatusNote',
      desc: '',
      args: [],
    );
  }

  /// `Body temperature`
  String get healthStatusTemperature {
    return Intl.message(
      'Body temperature',
      name: 'healthStatusTemperature',
      desc: '',
      args: [],
    );
  }

  /// `Health information`
  String get healthStatusTitle {
    return Intl.message(
      'Health information',
      name: 'healthStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add health information`
  String get homeHealthStatusButton {
    return Intl.message(
      'Add health information',
      name: 'homeHealthStatusButton',
      desc: '',
      args: [],
    );
  }

  /// `Load doctor appointments records`
  String get homePatientDoctorsAppointmentLoading {
    return Intl.message(
      'Load doctor appointments records',
      name: 'homePatientDoctorsAppointmentLoading',
      desc: '',
      args: [],
    );
  }

  /// `Error loading upcoming doctor appointments`
  String get homePatientDoctorsAppointmentLoadingError {
    return Intl.message(
      'Error loading upcoming doctor appointments',
      name: 'homePatientDoctorsAppointmentLoadingError',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming doctor appointments`
  String get homePatientDoctorsAppointmentTitle {
    return Intl.message(
      'Upcoming doctor appointments',
      name: 'homePatientDoctorsAppointmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `{date}, {doctorName} {doctorSurname} {doctorMiddleName}{nl}{doctorNote}`
  String homePatientDoctorsAppointmentToString(
      Object date,
      Object doctorName,
      Object doctorSurname,
      Object doctorMiddleName,
      Object nl,
      Object doctorNote) {
    return Intl.message(
      '$date, $doctorName $doctorSurname $doctorMiddleName$nl$doctorNote',
      name: 'homePatientDoctorsAppointmentToString',
      desc: '',
      args: [date, doctorName, doctorSurname, doctorMiddleName, nl, doctorNote],
    );
  }

  /// `No records`
  String get homePatientDoctorsAppointmentZeroElementLoaded {
    return Intl.message(
      'No records',
      name: 'homePatientDoctorsAppointmentZeroElementLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Loading Procedures`
  String get homePatientProcedureLoading {
    return Intl.message(
      'Loading Procedures',
      name: 'homePatientProcedureLoading',
      desc: '',
      args: [],
    );
  }

  /// `Error loading upcoming procedures`
  String get homePatientProcedureLoadingError {
    return Intl.message(
      'Error loading upcoming procedures',
      name: 'homePatientProcedureLoadingError',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming procedures`
  String get homePatientProcedureTitle {
    return Intl.message(
      'Upcoming procedures',
      name: 'homePatientProcedureTitle',
      desc: '',
      args: [],
    );
  }

  /// `{date}, {procedureName}{nl}{procedureNote}`
  String homePatientProcedureToString(
      Object date, Object procedureName, Object nl, Object procedureNote) {
    return Intl.message(
      '$date, $procedureName$nl$procedureNote',
      name: 'homePatientProcedureToString',
      desc: '',
      args: [date, procedureName, nl, procedureNote],
    );
  }

  /// `No records `
  String get homePatientProcedureZeroElementLoaded {
    return Intl.message(
      'No records ',
      name: 'homePatientProcedureZeroElementLoaded',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while logging in. Check the correctness of the entered data and try again.`
  String get loginErrorNote {
    return Intl.message(
      'An error occurred while logging in. Check the correctness of the entered data and try again.',
      name: 'loginErrorNote',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get loginErrorTitle {
    return Intl.message(
      'Error',
      name: 'loginErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sing in`
  String get loginSingIn {
    return Intl.message(
      'Sing in',
      name: 'loginSingIn',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get loginWelcomeTitle {
    return Intl.message(
      'Welcome',
      name: 'loginWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add medication`
  String get medicineFloatingButton {
    return Intl.message(
      'Add medication',
      name: 'medicineFloatingButton',
      desc: '',
      args: [],
    );
  }

  /// `Take in the {time} {meals}`
  String medicineInstruction(Object time, Object meals) {
    return Intl.message(
      'Take in the $time $meals',
      name: 'medicineInstruction',
      desc: '',
      args: [time, meals],
    );
  }

  /// `Medicine data loading error`
  String get medicineLoadError {
    return Intl.message(
      'Medicine data loading error',
      name: 'medicineLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Drug's information loading`
  String get medicineLoading {
    return Intl.message(
      'Drug\'s information loading',
      name: 'medicineLoading',
      desc: '',
      args: [],
    );
  }

  /// `afternoon`
  String get medicineReceptionTimeDuringTheDay {
    return Intl.message(
      'afternoon',
      name: 'medicineReceptionTimeDuringTheDay',
      desc: '',
      args: [],
    );
  }

  /// `evening`
  String get medicineReceptionTimeInTheEvening {
    return Intl.message(
      'evening',
      name: 'medicineReceptionTimeInTheEvening',
      desc: '',
      args: [],
    );
  }

  /// `morning`
  String get medicineReceptionTimeInTheMorning {
    return Intl.message(
      'morning',
      name: 'medicineReceptionTimeInTheMorning',
      desc: '',
      args: [],
    );
  }

  /// `{remaining} left, but {leftToTake} prescribed`
  String medicineRunningOutMedication(Object remaining, Object leftToTake) {
    return Intl.message(
      '$remaining left, but $leftToTake prescribed',
      name: 'medicineRunningOutMedication',
      desc: '',
      args: [remaining, leftToTake],
    );
  }

  /// `after meals`
  String get medicineTakeAfterMeals {
    return Intl.message(
      'after meals',
      name: 'medicineTakeAfterMeals',
      desc: '',
      args: [],
    );
  }

  /// `before meals`
  String get medicineTakeBeforeMeals {
    return Intl.message(
      'before meals',
      name: 'medicineTakeBeforeMeals',
      desc: '',
      args: [],
    );
  }

  /// `Add a drug to the list of available`
  String get medicineTakeRunningOutMedicationErrorNote {
    return Intl.message(
      'Add a drug to the list of available',
      name: 'medicineTakeRunningOutMedicationErrorNote',
      desc: '',
      args: [],
    );
  }

  /// `Not enough doses`
  String get medicineTakeRunningOutMedicationErrorTitle {
    return Intl.message(
      'Not enough doses',
      name: 'medicineTakeRunningOutMedicationErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `with meals`
  String get medicineTakeWithMeals {
    return Intl.message(
      'with meals',
      name: 'medicineTakeWithMeals',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date: {date}\n{remaining} doses left`
  String medicineWillGoBad(Object date, Object remaining) {
    return Intl.message(
      'Expiration date: $date\n$remaining doses left',
      name: 'medicineWillGoBad',
      desc: '',
      args: [date, remaining],
    );
  }

  /// `Home`
  String get navBarHome {
    return Intl.message(
      'Home',
      name: 'navBarHome',
      desc: 'Домашнее меню',
      args: [],
    );
  }

  /// `Medicine`
  String get navBarMedicine {
    return Intl.message(
      'Medicine',
      name: 'navBarMedicine',
      desc: 'Меню с лекарствами',
      args: [],
    );
  }

  /// `Settings`
  String get navBarSettings {
    return Intl.message(
      'Settings',
      name: 'navBarSettings',
      desc: 'Меню настроек',
      args: [],
    );
  }

  /// `Sing out`
  String get settingsSignOut {
    return Intl.message(
      'Sing out',
      name: 'settingsSignOut',
      desc: 'кнопка выхода из аккаунта',
      args: [],
    );
  }

  /// `Authorized as`
  String get settingsUserTitle {
    return Intl.message(
      'Authorized as',
      name: 'settingsUserTitle',
      desc: 'Заголовок перед именем пользователя',
      args: [],
    );
  }

  /// `Close`
  String get takeMedicineCloseButton {
    return Intl.message(
      'Close',
      name: 'takeMedicineCloseButton',
      desc: '',
      args: [],
    );
  }

  /// `You'll have {doses} doses left`
  String takeMedicineDrugsRemaining(Object doses) {
    return Intl.message(
      'You\'ll have $doses doses left',
      name: 'takeMedicineDrugsRemaining',
      desc: '',
      args: [doses],
    );
  }

  /// `Save`
  String get takeMedicineSaveButton {
    return Intl.message(
      'Save',
      name: 'takeMedicineSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Try to reduce the number of doses you take`
  String get takeMedicineSaveErrorNote {
    return Intl.message(
      'Try to reduce the number of doses you take',
      name: 'takeMedicineSaveErrorNote',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get takeMedicineSaveErrorTitle {
    return Intl.message(
      'Error',
      name: 'takeMedicineSaveErrorTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
