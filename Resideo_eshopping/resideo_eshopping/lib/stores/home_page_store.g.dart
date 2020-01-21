// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageStore on _HomePageStore, Store {
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
}
