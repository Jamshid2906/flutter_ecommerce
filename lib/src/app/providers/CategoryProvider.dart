
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/categories/index.dart';
import 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier{

  void save(nametext,context) {
    CategoryController category = CategoryController();
    Map a = {
      'name'  : nametext,
      'created_at': FieldValue.serverTimestamp()
    };
    category.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryIndex.screen()));
        SnackBarMessages.successSnackBar(context, 'Data added successfully!');
      }
    });
  }

    void update(nametext,String id,context){
    CategoryController().update({
      'name'      : nametext,
      'created_at': Timestamp.fromDate(DateTime.now())
    }, id).then((value) {
      print('before 34 34 34 ');
      print(value);
      if(value!=null){
        print('34 34 34 34 ');
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryIndex()));
        SnackBarMessages.successSnackBar(context, 'Data updated successfully!');
      }
    });
  }

  // ignore: unused_element
  void delete(String id ,BuildContext context){
    CategoryController().delete(id).then((value) {
      if(value == true) {
        SnackBarMessages.successSnackBar(context, 'Item Deleted successfullty!');
        Navigator.pop(context);
        notifyListeners();
      }
    });
  }
}