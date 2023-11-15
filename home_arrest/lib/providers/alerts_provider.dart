import 'package:flutter/material.dart';

class ALertsProvider extends ChangeNotifier {
  final List<String> _alerts = [
    'Allison Weber',
    'Adnan Ghaffar',
    'JhonDoe',
    'James Bond',
  ];

  List<String> get alerts => _alerts;
}
