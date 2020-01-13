// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPageStore on _LoginPageStore, Store {
  Computed<bool> _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin)).value;

  final _$emailAtom = Atom(name: '_LoginPageStore.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_LoginPageStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$successAtom = Atom(name: '_LoginPageStore.success');

  @override
  bool get success {
    _$successAtom.context.enforceReadPolicy(_$successAtom);
    _$successAtom.reportObserved();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.context.conditionallyRunInAction(() {
      super.success = value;
      _$successAtom.reportChanged();
    }, _$successAtom, name: '${_$successAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_LoginPageStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$_formModeAtom = Atom(name: '_LoginPageStore._formMode');

  @override
  FormMode get _formMode {
    _$_formModeAtom.context.enforceReadPolicy(_$_formModeAtom);
    _$_formModeAtom.reportObserved();
    return super._formMode;
  }

  @override
  set _formMode(FormMode value) {
    _$_formModeAtom.context.conditionallyRunInAction(() {
      super._formMode = value;
      _$_formModeAtom.reportChanged();
    }, _$_formModeAtom, name: '${_$_formModeAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$_LoginPageStoreActionController =
      ActionController(name: '_LoginPageStore');

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginPageStoreActionController.startAction();
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginPageStoreActionController.startAction();
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_LoginPageStoreActionController.startAction();
    try {
      return super.validateEmail(value);
    } finally {
      _$_LoginPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_LoginPageStoreActionController.startAction();
    try {
      return super.validatePassword(value);
    } finally {
      _$_LoginPageStoreActionController.endAction(_$actionInfo);
    }
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool> _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??=
          Computed<bool>(() => super.hasErrorsInLogin))
      .value;

  final _$emailAtom = Atom(name: '_FormErrorStore.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }
}
