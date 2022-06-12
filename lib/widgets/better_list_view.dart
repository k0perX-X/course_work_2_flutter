import 'package:flutter/material.dart';

class BetterListView extends StatefulWidget {
  const BetterListView(this.items, {Key? key}) : super(key: key);

  final List<Widget> items;

  @override
  State<StatefulWidget> createState() => _BetterListView();
}

class _BetterListView extends State<BetterListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return Card(child: widget.items[index]);
      },
    );
  }
}
