// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(
          date, doctorName, doctorSurname, doctorMiddleName, nl, doctorNote) =>
      "${date}, ${doctorName} ${doctorSurname} ${doctorMiddleName} ${nl} ${doctorNote}";

  static String m1(date, procedureName, nl, procedureNote) =>
      "${date}, ${procedureName} ${nl} ${procedureNote}";

  static String m2(time, meals) => "Принимать ${time} ${meals} ";

  static String m3(remaining, leftToTake) =>
      "Осталось ${remaining}, но прописано ${leftToTake}";

  static String m4(date, remaining) =>
      "Срок годности: ${date}\nОсталось: ${remaining} доз";

  static String m5(doses) => "У вас останется ${doses} доз";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Приложение пациента"),
        "homePatientDoctorsAppointmentLoading":
            MessageLookupByLibrary.simpleMessage("Загрузка записей ко врачу"),
        "homePatientDoctorsAppointmentLoadingError":
            MessageLookupByLibrary.simpleMessage(
                "Ошибка загрузки предстоящих записей ко врачу"),
        "homePatientDoctorsAppointmentTitle":
            MessageLookupByLibrary.simpleMessage("Предстоящие записи ко врачу"),
        "homePatientDoctorsAppointmentToString": m0,
        "homePatientDoctorsAppointmentZeroElementLoaded":
            MessageLookupByLibrary.simpleMessage("Записи отсутствуют"),
        "homePatientProcedureLoading":
            MessageLookupByLibrary.simpleMessage("Загрузка процедур"),
        "homePatientProcedureLoadingError":
            MessageLookupByLibrary.simpleMessage(
                "Ошибка загрузки предстоящих процедур"),
        "homePatientProcedureTitle":
            MessageLookupByLibrary.simpleMessage("Предстоящие процедуры"),
        "homePatientProcedureToString": m1,
        "homePatientProcedureZeroElementLoaded":
            MessageLookupByLibrary.simpleMessage("Записи отсутствуют "),
        "loginErrorNote": MessageLookupByLibrary.simpleMessage(
            "Произошла ошибка при входе. Проверьте корректность введенных данных и попробуйте снова. "),
        "loginErrorTitle": MessageLookupByLibrary.simpleMessage("Ошибка"),
        "loginSingIn": MessageLookupByLibrary.simpleMessage("Войти"),
        "loginWelcomeTitle":
            MessageLookupByLibrary.simpleMessage("Добро\nпожаловать"),
        "medicineInstruction": m2,
        "medicineLoadError": MessageLookupByLibrary.simpleMessage(
            "Ошибка загрузки данных о лекарствах"),
        "medicineLoading": MessageLookupByLibrary.simpleMessage(
            "Загрузка данных о лекарствах"),
        "medicineReceptionTimeDuringTheDay":
            MessageLookupByLibrary.simpleMessage("днем"),
        "medicineReceptionTimeInTheEvening":
            MessageLookupByLibrary.simpleMessage("вечером"),
        "medicineReceptionTimeInTheMorning":
            MessageLookupByLibrary.simpleMessage("утром"),
        "medicineRunningOutMedication": m3,
        "medicineTakeAfterMeals":
            MessageLookupByLibrary.simpleMessage("после еды"),
        "medicineTakeBeforeMeals":
            MessageLookupByLibrary.simpleMessage("до еды"),
        "medicineTakeRunningOutMedicationErrorNote":
            MessageLookupByLibrary.simpleMessage(
                "Добавьте лекарство в список имеющихся"),
        "medicineTakeRunningOutMedicationErrorTitle":
            MessageLookupByLibrary.simpleMessage(
                "Недостаточное количество доз"),
        "medicineTakeWithMeals": MessageLookupByLibrary.simpleMessage("с едой"),
        "medicineWillGoBad": m4,
        "navBarHome": MessageLookupByLibrary.simpleMessage("Дом"),
        "navBarMedicine": MessageLookupByLibrary.simpleMessage("Лекарства"),
        "navBarSettings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "settingsSignOut":
            MessageLookupByLibrary.simpleMessage("Выйти из аккаунта"),
        "settingsUserTitle":
            MessageLookupByLibrary.simpleMessage("Авторизирован как"),
        "takeMedicineCloseButton":
            MessageLookupByLibrary.simpleMessage("Закрыть"),
        "takeMedicineDrugsRemaining": m5,
        "takeMedicineSaveButton":
            MessageLookupByLibrary.simpleMessage("Сохранить"),
        "takeMedicineSaveErrorNote": MessageLookupByLibrary.simpleMessage(
            "Попробуйте уменьшить количество принятых доз лекарства"),
        "takeMedicineSaveErrorTitle":
            MessageLookupByLibrary.simpleMessage("Ошибка")
      };
}
