import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';


void main()
{
   group("product_detail", (){
     test("button disable", (){
       ProductController productController = ProductController();
       bool res = productController.enableDisableOrderNowButton(0);
       expect(true, res);
     });
     test("button enabled", (){
       ProductController productController = ProductController();
       bool res = productController.enableDisableOrderNowButton(1);
       expect(false, res);
     });
     test("In Stock", (){
       ProductController productController = ProductController();
       String res = productController.inventoryDetail(5);
       expect("In Stock", res);
     });
     test("Out of Stock", (){
       ProductController productController = ProductController();
       String res = productController.inventoryDetail(0);
       expect("Out of Stock", res);
     });
     test("Item Left", (){
       ProductController productController = ProductController();
       String res = productController.inventoryDetail(4);
       expect("Only 4 left", res);
     });
     test("Inventory_color_red", (){
       ProductController productController = ProductController();
       expect(Color(0xFFF44336), productController.inventoryDetailColor(4));
     });
     test("Inventory_color_green", (){
       ProductController productController = ProductController();
       expect(Color(0xFF00C853), productController.inventoryDetailColor(10));
     });
   });
}