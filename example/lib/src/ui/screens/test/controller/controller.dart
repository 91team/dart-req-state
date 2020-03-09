import 'dart:async';

import 'package:mobx/mobx.dart';

part 'controller.g.dart';

class TestScreenController = TestScreenControllerBase
    with _$TestScreenController;

abstract class TestScreenControllerBase with Store {
  @observable
  bool isSwitcherEnabled = false;

  TestScreenControllerBase() : isSwitcherEnabled = false;

  setIsSwitcherEnabled(bool next) {
    isSwitcherEnabled = next;
  }

  void init() {}
}
