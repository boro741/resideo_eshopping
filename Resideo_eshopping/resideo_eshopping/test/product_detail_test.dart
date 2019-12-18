import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';


void main()
{
   group("product_detail", (){
     test("button disable", (){
       ProductController productController = ProductController();
       bool res = productController.enableDisableOrderNowButton(0);
       expect(res, true);
     });
     test("button enabled", (){
       ProductController productController = ProductController();
       bool res = productController.enableDisableOrderNowButton(1);
       expect(res, false);
     });
     test("In Stock", (){
       ProductController productController = ProductController();
       String res = productController.inventoryDetail(5);
       expect(res, "In Stock");
     });
     test("Out of Stock", (){
       ProductController productController = ProductController();
       String res = productController.inventoryDetail(0);
       expect(res, "Out of Stock");
     });
     test("Item Left", (){
       ProductController productController = ProductController();
       String res = productController.inventoryDetail(4);
       expect(res, "Only 4 left");
     });
     test("Filter_for_All", (){
       ProductController productController = ProductController();
       expect(productController.filterProducts("All"), []);
     });
     test("Filter_for_Men", (){
       ProductController productController = ProductController();
       expect(productController.filterProducts("Men"), []);
     });
     test("Filter_for_Women", (){
       ProductController productController = ProductController();
       expect(productController.filterProducts("Women"), []);
     });
     test("Inventory_color_red", (){
       ProductController productController = ProductController();
       expect(productController.inventoryDetailColor(4), Color(0xFFF44336));
     });
     test("Inventory_color_green", (){
       ProductController productController = ProductController();
       expect(productController.inventoryDetailColor(10), Color(0xFF00C853));
     });
   });
}