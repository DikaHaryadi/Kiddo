import 'package:flutter/material.dart';

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600;

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
