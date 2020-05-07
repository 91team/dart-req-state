// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TestScreenController on TestScreenControllerBase, Store {
  final _$metaIsSwitcherEnabledAtom = Atom(name: 'TestScreenControllerBase.metaIsSwitcherEnabled');

  @override
  bool get metaIsSwitcherEnabled {
    _$metaIsSwitcherEnabledAtom.context.enforceReadPolicy(_$metaIsSwitcherEnabledAtom);
    _$metaIsSwitcherEnabledAtom.reportObserved();
    return super.metaIsSwitcherEnabled;
  }

  @override
  set metaIsSwitcherEnabled(bool value) {
    _$metaIsSwitcherEnabledAtom.context.conditionallyRunInAction(() {
      super.metaIsSwitcherEnabled = value;
      _$metaIsSwitcherEnabledAtom.reportChanged();
    }, _$metaIsSwitcherEnabledAtom, name: '${_$metaIsSwitcherEnabledAtom.name}_set');
  }

  final _$simpleIsSwitcherEnabledAtom = Atom(name: 'TestScreenControllerBase.simpleIsSwitcherEnabled');

  @override
  bool get mobxSimpleIsSwitcherEnabled {
    _$simpleIsSwitcherEnabledAtom.context.enforceReadPolicy(_$simpleIsSwitcherEnabledAtom);
    _$simpleIsSwitcherEnabledAtom.reportObserved();
    return super.mobxSimpleIsSwitcherEnabled;
  }

  @override
  set mobxSimpleIsSwitcherEnabled(bool value) {
    _$simpleIsSwitcherEnabledAtom.context.conditionallyRunInAction(() {
      super.mobxSimpleIsSwitcherEnabled = value;
      _$simpleIsSwitcherEnabledAtom.reportChanged();
    }, _$simpleIsSwitcherEnabledAtom, name: '${_$simpleIsSwitcherEnabledAtom.name}_set');
  }

  final _$metaPullItemsAsyncAction = AsyncAction('metaPullItems');

  @override
  Future metaPullItems() {
    return _$metaPullItemsAsyncAction.run(() => super.metaPullItems());
  }

  final _$simplePullItemsAsyncAction = AsyncAction('simplePullItems');

  @override
  Future simplePullItems() {
    return _$simplePullItemsAsyncAction.run(() => super.simplePullItems());
  }

  final _$TestScreenControllerBaseActionController = ActionController(name: 'TestScreenControllerBase');

  @override
  dynamic _metaSetIsSwitcherEnabled() {
    final _$actionInfo = _$TestScreenControllerBaseActionController.startAction();
    try {
      return super._metaSetIsSwitcherEnabled();
    } finally {
      _$TestScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _simpleSetIsSwitcherEnabled() {
    final _$actionInfo = _$TestScreenControllerBaseActionController.startAction();
    try {
      return super._simpleSetIsSwitcherEnabled();
    } finally {
      _$TestScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'metaIsSwitcherEnabled: ${metaIsSwitcherEnabled.toString()},simpleIsSwitcherEnabled: ${mobxSimpleIsSwitcherEnabled.toString()}';
    return '{$string}';
  }
}
