import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:course_work_2_flutter/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:course_work_2_flutter/scripts/sing_out.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        // объект EdgeInsets хранит четыре важные double переменные:
        // left, top, right, bottom - отступ слева, сверху, справа и снизу
        // EdgeInsets.all(10) - задает одинаковый отступ со всех сторон
        // EdgeInsets.only(left: 10, right: 15) - задает отступ для
        // определенной стороны или сторон
        // EdgeInsets.symmetric - позволяет указать одинаковые
        // отступы по горизонтали (left и right) и по вертикали (top и bottom)
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        // создаем наш список
        child: ListView(children: [
          Text(AppLocalizations.of(context)!.settingsUserTitle,
              style: Theme.of(context).textTheme.headline2!),
          Text(globals.settings.getString("name") ?? "",
              style: Theme.of(context).textTheme.headline4!),
          Text(globals.settings.getString("surname") ?? "",
              style: Theme.of(context).textTheme.headline4!),
          Visibility(
              visible: globals.settings.getString("middleName") == null
                  ? false
                  : globals.settings.getString("middleName") != "",
              child: Text(globals.settings.getString("middleName") ?? "",
                  style: Theme.of(context).textTheme.headline4!)),
          Stack(children: [ElevatedButton.icon(
              onPressed: () => {singOut(context)},
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              label: Text(
                AppLocalizations.of(context)!.settingsSignOut,
                style: const TextStyle(color: Colors.red),
              )
          )])
        ]));
  }
}
