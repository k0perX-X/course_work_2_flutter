import 'package:flutter/material.dart';

class ApplicationSection extends StatefulWidget {
  final String title;
  final TextStyle titleStyle;
  final List<TextLine> textLines;

  const ApplicationSection(this.title, this.titleStyle, this.textLines,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplicationSection();
}

typedef OnTap = void Function();

class TextLine {
  final String text;
  final TextStyle style;
  final void Function() func;

  TextLine(this.text, this.func, this.style);
}

class _ApplicationSection extends State<ApplicationSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // указываем отступ для контента
      padding: const EdgeInsets.all(15),
      // Column размещает дочерние виджеты в виде колонки
      // crossAxisAlignment - выравнивание по ширине (колонка) или
      // по высоте (строка)
      // mainAxisAlignment работает наоборот
      // в данном случае мы растягиваем дочерние элементы
      // на всю ширину колонки
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
              InkWell(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      // вы не можете указать color для Container,
                      // т.к. свойство decoration было определено
                      // color: Colors.pinkAccent,

                      // BoxDecoration имеет дополнительные свойства,
                      // посравнению с Container,
                      // такие как: gradient, borderRadius, border, shape
                      // и boxShadow
                      // здесь мы задаем радиус закругления левого и правого
                      // верхних углов
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        // цвет Container'а мы указываем в BoxDecoration
                        color: Colors.pinkAccent,
                      ),
                      child: Text(
                        // указываем имя pony
                        widget.title,
                        style: widget.titleStyle,
                      )))
            ] +
            List.generate(
                widget.textLines.length,
                (index) => InkWell(
                    onTap: widget.textLines[index].func,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.textLines[index].text,
                        style: widget.textLines[index].style,
                      ),
                    ))),
      ),
    );
  }
}
