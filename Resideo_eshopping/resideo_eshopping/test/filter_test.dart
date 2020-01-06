import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';

class ProductMock extends Mock implements Product {

  @override
  // TODO: implement category
  String get category => 'men';

}

class MockProductController extends Mock implements ProductController{
  @override
  ProductMock pd = ProductMock();
  //static List<ProductMock> products = <ProductMock>[];
  filterProducts(String value) {
    // TODO: implement filterProducts
    int sum_all = 1;
    int sum_men = 0;
    int sum_women = 0;
    int sum_kids = 0;
    if(pd.category == 'men')
      sum_men = sum_men+1;
//    for(products c in ProductMock) {
//      if (c.category == 'women')
//        sum_women = sum_women + 1;
//      else if(c.category == 'men')
//        sum_men = sum_men + 1;
//      else
//        sum_kids = sum_kids + 1;
//    }
    if(value == 'All')
      return sum_all;
    else if(value == 'men')
      return sum_men;
    else if(value == 'women')
      return sum_women;
    else
      return sum_kids;
  }

}

void main() {

  test("filter for all", () {
    MockProductController fun = MockProductController();
    int res = fun.filterProducts('All');
    expect(res, 1);
  });

  test("filter for men", () {
    MockProductController fun = MockProductController();
    int res = fun.filterProducts('men');
    expect(res, 1);
  });

  test("filter for women", () {
    MockProductController fun = MockProductController();
    int res = fun.filterProducts('women');
    expect(res, 0);
  });

  test("filter for kid", () {
    MockProductController fun = MockProductController();
    int res = fun.filterProducts('kid');
    expect(res, 0);
  });

}





