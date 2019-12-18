
import 'package:flutter/material.dart';

class StarDisplay extends StatefulWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  _StarDisplayState createState() => _StarDisplayState();
}

class _StarDisplayState extends State<StarDisplay> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < widget.value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}