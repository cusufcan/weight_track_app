import 'package:flutter/material.dart';

class CustomSubTitleText extends StatefulWidget {
  const CustomSubTitleText({super.key, required this.text});
  final String text;
  @override
  State<CustomSubTitleText> createState() => _CustomSubTitleTextState();
}

class _CustomSubTitleTextState extends State<CustomSubTitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text, style: Theme.of(context).textTheme.titleMedium);
  }
}
