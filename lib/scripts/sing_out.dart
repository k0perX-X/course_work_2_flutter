library course_work_2_flutter.scripts;

import 'package:course_work_2_flutter/scripts/reload_app.dart';
import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/globals.dart' as globals;

void singOut(BuildContext context) async {
  await globals.settings.clear();
  reloadApp(context);
}
