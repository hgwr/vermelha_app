import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vermelha_app/models/task.dart';

enum EngineStatus {
  running,
  paused,
}

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  EngineStatus _engineStatus = EngineStatus.paused;
  Timer? _timer;

  List<Task> get tasks => _tasks;
  EngineStatus get engineStatus => _engineStatus;

  void startEngine() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _engineStatus = EngineStatus.running;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      calculation();
    });
    notifyListeners();
  }

  void pauseEngine() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = null;
    _engineStatus = EngineStatus.paused;
    notifyListeners();
  }

  void calculation() {}
}
