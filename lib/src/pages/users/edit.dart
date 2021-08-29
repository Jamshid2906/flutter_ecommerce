import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/app/providers/UserProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserEdit extends StatefulWidget {
  UserEdit({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  _UserEditState createState() => _UserEditState();
   Widget screen() => ChangeNotifierProvider(
      create: (context) => UserProvider(),
      builder: (context, child) => UserEdit(id:id)
    );
}


class _UserEditState extends State<UserEdit> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    UserController().edit(widget.id).then((value){
      if (value != null) {
        usernameController.text = value['username'];
        phoneController.text = value['phone'];
        passwordController.text = value['password'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
 
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Edit'),
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
          userProvider.update(usernameController.text, phoneController.text, passwordController.text, widget.id, context);
        },
      ),
    );
  }
}