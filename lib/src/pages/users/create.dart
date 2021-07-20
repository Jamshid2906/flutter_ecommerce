import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';


class UserCreate extends StatefulWidget {
  UserCreate({Key? key}) : super(key: key);
  @override
  _UserCreateState createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void save() {
    UserController user = UserController();
    Map a = {
      'username': usernameController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
    };
    user.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserIndex()));
        SnackBarMessages.successSnackBar(context, 'Data added successfully!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Add'),
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new))
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: save,
      ),
    );
  }
}
