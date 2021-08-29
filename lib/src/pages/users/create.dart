import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/providers/UserProvider.dart';
import 'package:provider/provider.dart';


class UserCreate extends StatefulWidget {
  UserCreate({Key? key}) : super(key: key);
  @override
  _UserCreateState createState() => _UserCreateState();

  static Widget screen() => ChangeNotifierProvider(
      create: (context) => UserProvider(),
      builder: (context, child) => UserCreate()
    );
}

class _UserCreateState extends State<UserCreate> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

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
        onPressed: (){
          userProvider.save(usernameController.text, phoneController.text, passwordController.text, context);
        },
      ),
    );
  }
}
