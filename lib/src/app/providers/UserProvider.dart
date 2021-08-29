import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:flutter_ecommerce/src/pages/users/create.dart';
import 'package:flutter_ecommerce/src/pages/users/edit.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';

class UserProvider extends ChangeNotifier {
  void save(usernameValue, phoneValue, passwordValue, context) {
    UserController user = UserController();
    Map<String, dynamic> a = {
      'username': usernameValue,
      'phone': phoneValue,      
      'password': passwordValue,
    };
    user.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserIndex.screen()));
        SnackBarMessages.successSnackBar(context, 'Data added successfully!');
      }
    });
  }

  void update(usernameValue, phoneValue, passwordValue, id, context) {
    Map<String, dynamic> a = {
      'username': usernameValue,
      'phone': phoneValue,
      'password': passwordValue,
    };
    UserController().update(a, id).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserIndex()));
        SnackBarMessages.successSnackBar(context, 'Data updated successfully!');
      }
    });
  }

  void delete(String id, context) {
    UserController().delete(id).then((value) {
      if (value == true) {
        SnackBarMessages.successSnackBar(
            context, 'Item Deleted successfullty!');
        Navigator.pop(context);
        notifyListeners();
      }
    });
  }

  void nextCreateScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserCreate.screen()));
  }

  void nextEditScreen(id, context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserEdit(
                  id: id,
                ).screen()));
  }

  void backMainScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
