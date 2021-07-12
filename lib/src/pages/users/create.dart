import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';


class UserCreate extends StatefulWidget {
  UserCreate({Key? key}) : super(key: key);
  @override
  _UserCreateState createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  TextEditingController username_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  void save() {
    UserController user = UserController();
    Map a = {
      'username': username_controller.text,
      'phone': phone_controller.text,
      'password': password_controller.text,
    };
    user.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserIndex()));
        setState(() {
          
        });
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
              controller: username_controller,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: phone_controller,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: password_controller,
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
