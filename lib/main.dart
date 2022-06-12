import 'dart:async';
import 'package:course_work_2_flutter/pages/home_page.dart';
import 'package:course_work_2_flutter/pages/medicine_page.dart';
import 'package:course_work_2_flutter/pages/settings_page.dart';
import 'package:course_work_2_flutter/pages/login_page.dart';
import 'package:course_work_2_flutter/pages/take_medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:course_work_2_flutter/globals.dart' as globals;
import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  //setup flutter_native_splash
  WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized(); //инициализация приложения
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //инициализация globals
  globals.settings = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: true,
          primaryColor: globals.accentColor,),
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      home: const StartAppWidget(),
      // initialRoute: '/',
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => const StartAppWidget(),
      //   '/main': (BuildContext context) => const ScaffoldNavigatorBar(),
      //   '/login': (BuildContext context) => const LoginPage(),
      // },
    );
  }
}

class StartAppWidget extends StatelessWidget {
  const StartAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => globals.settings.get('token') == null
      ? const LoginPage()
      : const ScaffoldNavigatorBar();
}

class ScaffoldNavigatorBar extends StatefulWidget {
  const ScaffoldNavigatorBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaffoldNavigatorBar();
}

class _ScaffoldNavigatorBar extends State<ScaffoldNavigatorBar> {
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MedicinePage(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context)!.appTitle),
      //   // systemOverlayStyle: const SystemUiOverlayStyle(
      //   //   // Status bar color
      //   //   statusBarColor: Colors.white,
      //   //
      //   //   // Status bar brightness (optional)
      //   //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      //   //   statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      //   // ),
      // ),
      body: SafeArea(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.navBarHome),
          BottomNavigationBarItem(
              icon: const Icon(Icons.add_business),
              label: AppLocalizations.of(context)!.navBarMedicine),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.navBarSettings)
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// // main() является главной функцией с которой начинается
// // выполнение приложения
// // возвращает виджет приложения
// void main() => runApp(const MyApp());
//
// // В Flutter все является виджетом (кнопки,списки, текст и т.д.)
// // виджет - это отдельный компонент, который может быть отрисован
// // на экране (не путать с Android виджетами)
// // Наиболее простые виджеты наследуются от StatelessWidget класса
// // и не имеют состояния
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//
//   // функция build отвечает за построение иерархии виджетов
//   @override
//   Widget build(BuildContext context) {
//     // виджет MaterialApp - главный виджет приложения, который
//     // позволяет настроить тему и использовать
//     // Material Design для разработки.
//     return MaterialApp(
//       // заголовок приложения
//       // обычно виден, когда мы сворачиваем приложение
//       //title: 'Json Placeholder App',
//       // настройка темы, мы ещё вернёмся к этому
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // указываем исходную страницу, которую мы создадим позже
//       home: const HomePage(),
//     );
//   }
// }
