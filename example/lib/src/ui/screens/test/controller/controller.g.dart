// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TestScreenController on TestScreenControllerBase, Store {
  final _$isSwitcherEnabledAtom =
      Atom(name: 'TestScreenControllerBase.isSwitcherEnabled');

  @override
  bool get isSwitcherEnabled {
    _$isSwitcherEnabledAtom.context.enforceReadPolicy(_$isSwitcherEnabledAtom);
    _$isSwitcherEnabledAtom.reportObserved();
    return super.isSwitcherEnabled;
  }

  @override
  set isSwitcherEnabled(bool value) {
    _$isSwitcherEnabledAtom.context.conditionallyRunInAction(() {
      super.isSwitcherEnabled = value;
      _$isSwitcherEnabledAtom.reportChanged();
    }, _$isSwitcherEnabledAtom, name: '${_$isSwitcherEnabledAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'isSwitcherEnabled: ${isSwitcherEnabled.toString()}';
    return '{$string}';
  }
}
