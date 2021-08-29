import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/ProductController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/products/index.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  void save(nameValue, priceValue, descValue, context) {
    ProductController product = ProductController();
    Map a = {
      'name': nameValue,
      'price': priceValue,
      'desc': descValue,
    };
    product.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductIndex.screen()));
        SnackBarMessages.successSnackBar(context, 'Data added successfully!');
      }
    });
  }

  void update(nameValue, priceValue, descValue, id, context) {
    Map a = {
      'name': nameValue,
      'price': priceValue,
      'desc': descValue,
    };
    ProductController().update(a, id).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductIndex()));
        SnackBarMessages.successSnackBar(context, 'Data updated successfully!');
      }
    });
  }

  void delete(String id, context) {
    ProductController().delete(id).then((value) {
      if (value == true) {
        SnackBarMessages.successSnackBar(
            context, 'Item Deleted successfullty!');
        Navigator.pop(context);
        notifyListeners();
      }
    });
  }
}
