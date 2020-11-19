import 'package:flutter/material.dart';

class TitledNavBarItem {
  final Widget title;
  final Widget logo;
  final Color backgroundColor;

  TitledNavBarItem({
    @required this.title,
    @required this.logo,
    this.backgroundColor = Colors.white,
  });
}
