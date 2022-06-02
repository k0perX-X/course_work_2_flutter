import 'package:flutter/material.dart';
import 'package:course_work_2_flutter/widgets/application_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
          ApplicationSection("Посещение врача", Theme.of(context).textTheme.headline2!, [
            TextLine("ghjdth\nasda\n\nawdawd", () {},
                Theme.of(context).textTheme.bodyText1!),
            TextLine("ghjdth\nasda\n\nawdawd", () {},
                Theme.of(context).textTheme.bodyText1!)
          ])
        ]));
  }
}

// // StatefulWidget имеет состояние, с которым
// // позже мы будем работать через функцию
// // setState(VoidCallback fn);
// // обратите внимание setState принимает другую функцию
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   // StatefulWidget должен возвращать класс,
//   // которые наследуются от State
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// // В треугольных скобках мы указываем наш StatefulWidget
// // для которого будет создано состояние
// // нижнее подчеркивание _ используется для того,
// // чтобы скрыть доступ к _HomePageState  из других файлов
// // нижнее подчеркивание аналогия private в Java / Kotlin
// class _HomePageState extends State<HomePage> {
//
//   // функция build, как мы уже отметили, строит
//   // иерархию наших любимых виджетов
//   @override
//   Widget build(BuildContext context) {
//     // В большинстве случаев Scaffold используется,
//     // как корневой виджет для страницы или экрана
//     // Scaffold позволяет вам указать AppBar, BottomNavigationBar,
//     // Drawer, FloatingActionButton и другие не менее важные
//     // компоненты (виджеты).
//     return Scaffold(
//       // мы создаем AppBar с текстом "Home Page"
//         appBar: AppBar(title: Text("Home page")),
//         // указываем текст в качестве тела Scaffold
//         // текст предварительно вложен в Center виджет,
//         // чтобы выровнять его по центру
//         body: Center(
//             child: Text(
//               "Hello, JSON Placeholder!!!",
//               // Также выравниваем текст внутри самого виджета Text
//               textAlign: TextAlign.center,
//               // Theme.of(context) позволяет получить доступ к
//               // текущему ThemeData, который был указан в MaterialApp
//               // После получения ThemeData мы можем использовать
//               // различные его стили (например headline3, как здесь)
//               style: Theme.of(context).textTheme.headline3,
//             )
//         )
//     );
//   }
//
// }
