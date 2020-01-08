import 'package:flutter_test/flutter_test.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';
import 'package:resideo_eshopping/services/product_data_services.dart';
import 'package:resideo_eshopping/model/product.dart';


void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();
  List<Product> products = await loadProducts();
  ProductController productController = ProductController();
  productController.products = products;

  test("filter for all", () {
    expect(25, productController.filterProducts('All').length);
  });

  test("filter for men", () {
    expect(9, productController.filterProducts('Men').length);
  });

  test("filter for women", () {
    expect(8, productController.filterProducts('Women').length);
  });

  test("filter for kid", () {
    expect(8, productController.filterProducts('Kid').length);
  });

}
