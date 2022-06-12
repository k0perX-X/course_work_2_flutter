// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(
          date, doctorName, doctorSurname, doctorMiddleName, nl, doctorNote) =>
      "${date}, ${doctorName} ${doctorSurname} ${doctorMiddleName}${nl}${doctorNote}";

  static String m1(date, procedureName, nl, procedureNote) =>
      "${date}, ${procedureName}${nl}${procedureNote}";

  static String m2(time, meals) => "Take in the ${time} ${meals}";

  static String m3(remaining, leftToTake) =>
      "${remaining} left, but ${leftToTake} prescribed";

  static String m4(date, remaining) =>
      "Expiration date: ${date}\n${remaining} doses left";

  static String m5(doses) => "You\'ll have ${doses} doses left";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Patient Application"),
        "homePatientDoctorsAppointmentLoading":
            MessageLookupByLibrary.simpleMessage(
                "Load doctor appointments records"),
        "homePatientDoctorsAppointmentLoadingError":
            MessageLookupByLibrary.simpleMessage(
                "Error loading upcoming doctor appointments"),
        "homePatientDoctorsAppointmentTitle":
            MessageLookupByLibrary.simpleMessage(
                "Upcoming doctor appointments"),
        "homePatientDoctorsAppointmentToString": m0,
        "homePatientDoctorsAppointmentZeroElementLoaded":
            MessageLookupByLibrary.simpleMessage("No records"),
        "homePatientProcedureLoading":
            MessageLookupByLibrary.simpleMessage("Loading Procedures"),
        "homePatientProcedureLoadingError":
            MessageLookupByLibrary.simpleMessage(
                "Error loading upcoming procedures"),
        "homePatientProcedureTitle":
            MessageLookupByLibrary.simpleMessage("Upcoming procedures"),
        "homePatientProcedureToString": m1,
        "homePatientProcedureZeroElementLoaded":
            MessageLookupByLibrary.simpleMessage("No records "),
        "loginErrorNote": MessageLookupByLibrary.simpleMessage(
            "An error occurred while logging in. Check the correctness of the entered data and try again."),
        "loginErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
        "loginSingIn": MessageLookupByLibrary.simpleMessage("Sing in"),
        "loginWelcomeTitle": MessageLookupByLibrary.simpleMessage("Welcome"),
        "medicineInstruction": m2,
        "medicineLoadError":
            MessageLookupByLibrary.simpleMessage("Medicine data loading error"),
        "medicineLoading":
            MessageLookupByLibrary.simpleMessage("Drug\'s information loading"),
        "medicineReceptionTimeDuringTheDay":
            MessageLookupByLibrary.simpleMessage("afternoon"),
        "medicineReceptionTimeInTheEvening":
            MessageLookupByLibrary.simpleMessage("evening"),
        "medicineReceptionTimeInTheMorning":
            MessageLookupByLibrary.simpleMessage("morning"),
        "medicineRunningOutMedication": m3,
        "medicineTakeAfterMeals":
            MessageLookupByLibrary.simpleMessage("after meals"),
        "medicineTakeBeforeMeals":
            MessageLookupByLibrary.simpleMessage("before meals"),
        "medicineTakeRunningOutMedicationErrorNote":
            MessageLookupByLibrary.simpleMessage(
                "Add a drug to the list of available"),
        "medicineTakeRunningOutMedicationErrorTitle":
            MessageLookupByLibrary.simpleMessage("Not enough doses"),
        "medicineTakeWithMeals":
            MessageLookupByLibrary.simpleMessage("with meals"),
        "medicineWillGoBad": m4,
        "navBarHome": MessageLookupByLibrary.simpleMessage("Home"),
        "navBarMedicine": MessageLookupByLibrary.simpleMessage("Medicine"),
        "navBarSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingsSignOut": MessageLookupByLibrary.simpleMessage("Sing out"),
        "settingsUserTitle":
            MessageLookupByLibrary.simpleMessage("Authorized as"),
        "takeMedicineCloseButton":
            MessageLookupByLibrary.simpleMessage("Close"),
        "takeMedicineDrugsRemaining": m5,
        "takeMedicineSaveButton": MessageLookupByLibrary.simpleMessage("Save"),
        "takeMedicineSaveErrorNote": MessageLookupByLibrary.simpleMessage(
            "Try to reduce the number of doses you take"),
        "takeMedicineSaveErrorTitle":
            MessageLookupByLibrary.simpleMessage("Error")
      };
}
