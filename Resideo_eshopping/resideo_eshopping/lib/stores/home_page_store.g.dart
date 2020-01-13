// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageStore on _HomePageStore, Store {
  final _$statusAtom = Atom(name: '_HomePageStore.status');

  @override
  Status get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(Status value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$userIdAtom = Atom(name: '_HomePageStore.userId');

  @override
  String get userId {
    _$userIdAtom.context.enforceReadPolicy(_$userIdAtom);
    _$userIdAtom.reportObserved();
    return super.userId;
  }

  @override
  set userId(String value) {
    _$userIdAtom.context.conditionallyRunInAction(() {
      super.userId = value;
      _$userIdAtom.reportChanged();
    }, _$userIdAtom, name: '${_$userIdAtom.name}_set');
  }

  final _$logInButtonPressAtom = Atom(name: '_HomePageStore.logInButtonPress');

  @override
  bool get logInButtonPress {
    _$logInButtonPressAtom.context.enforceReadPolicy(_$logInButtonPressAtom);
    _$logInButtonPressAtom.reportObserved();
    return super.logInButtonPress;
  }

  @override
  set logInButtonPress(bool value) {
    _$logInButtonPressAtom.context.conditionallyRunInAction(() {
      super.logInButtonPress = value;
      _$logInButtonPressAtom.reportChanged();
    }, _$logInButtonPressAtom, name: '${_$logInButtonPressAtom.name}_set');
  }

  final _$onSignedOutAsyncAction = AsyncAction('onSignedOut');

  @override
  Future onSignedOut() {
    return _$onSignedOutAsyncAction.run(() => super.onSignedOut());
  }

  final _$_HomePageStoreActionController =
      ActionController(name: '_HomePageStore');

  @override
  bool onlogInButtonPress() {
    final _$actionInfo = _$_HomePageStoreActionController.startAction();
    try {
      return super.onlogInButtonPress();
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }
}
