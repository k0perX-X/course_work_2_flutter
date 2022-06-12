library course_work_2_flutter.scripts;

import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/main.dart';

void reloadApp(BuildContext context) {
  while (Navigator.canPop(context))
    {
      Navigator.pop(context);
    }
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const StartAppWidget()));
}
