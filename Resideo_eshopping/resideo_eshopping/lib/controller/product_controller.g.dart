// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductController on ProductControllerBase, Store {
  final _$productsAtom = Atom(name: 'ProductControllerBase.products');

  @override
  List<Product> get products {
    _$productsAtom.context.enforceReadPolicy(_$productsAtom);
    _$productsAtom.reportObserved();
    return super.products;
  }

  @override
  set products(List<Product> value) {
    _$productsAtom.context.conditionallyRunInAction(() {
      super.products = value;
      _$productsAtom.reportChanged();
    }, _$productsAtom, name: '${_$productsAtom.name}_set');
  }

  final _$currentListAtom = Atom(name: 'ProductControllerBase.currentList');

  @override
  List<Product> get currentList {
    _$currentListAtom.context.enforceReadPolicy(_$currentListAtom);
    _$currentListAtom.reportObserved();
    return super.currentList;
  }

  @override
  set currentList(List<Product> value) {
    _$currentListAtom.context.conditionallyRunInAction(() {
      super.currentList = value;
      _$currentListAtom.reportChanged();
    }, _$currentListAtom, name: '${_$currentListAtom.name}_set');
  }

  final _$getProductListAsyncAction = AsyncAction('getProductList');

  @override
  Future<List<Product>> getProductList(String value) {
    return _$getProductListAsyncAction.run(() => super.getProductList(value));
  }

  final _$updateProductModelAsyncAction = AsyncAction('updateProductModel');

  @override
  Future updateProductModel() {
    return _$updateProductModelAsyncAction
        .run(() => super.updateProductModel());
  }

  final _$ProductControllerBaseActionController =
      ActionController(name: 'ProductControllerBase');

  @override
  dynamic filterProducts(String value) {
    final _$actionInfo = _$ProductControllerBaseActionController.startAction();
    try {
      return super.filterProducts(value);
    } finally {
      _$ProductControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int _decreaseInventoryCount(Product product) {
    final _$actionInfo = _$ProductControllerBaseActionController.startAction();
    try {
      return super._decreaseInventoryCount(product);
    } finally {
      _$ProductControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateInventory(Product product) {
    final _$actionInfo = _$ProductControllerBaseActionController.startAction();
    try {
      return super.updateInventory(product);
    } finally {
      _$ProductControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
