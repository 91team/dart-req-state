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
  bool get metaIsSwitcherEnabled {
    _$isSwitcherEnabledAtom.context.enforceReadPolicy(_$isSwitcherEnabledAtom);
    _$isSwitcherEnabledAtom.reportObserved();
    return super.metaIsSwitcherEnabled;
  }

  @override
  set metaIsSwitcherEnabled(bool value) {
    _$isSwitcherEnabledAtom.context.conditionallyRunInAction(() {
      super.metaIsSwitcherEnabled = value;
      _$isSwitcherEnabledAtom.reportChanged();
    }, _$isSwitcherEnabledAtom, name: '${_$isSwitcherEnabledAtom.name}_set');
  }

  final _$pullItemsAsyncAction = AsyncAction('pullItems');

  @override
  Future metaPullItems() {
    return _$pullItemsAsyncAction.run(() => super.metaPullItems());
  }

  final _$TestScreenControllerBaseActionController =
      ActionController(name: 'TestScreenControllerBase');

  @override
  dynamic _metaSetIsSwitcherEnabled() {
    final _$actionInfo =
        _$TestScreenControllerBaseActionController.startAction();
    try {
      return super._metaSetIsSwitcherEnabled();
    } finally {
      _$TestScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isSwitcherEnabled: ${metaIsSwitcherEnabled.toString()}';
    return '{$string}';
  }
}
