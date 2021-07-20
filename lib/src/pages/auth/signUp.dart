import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/AuthController.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _save() {
    Map<String, dynamic> request = {
      'email': _emailController.text,
      'password': _passwordController.text
    };

    AuthController().signUp(request).then((value) {
      if(value != null){
        print('Sign Up succesfully!');
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserIndex()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:0.0,horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 45),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              controller: _emailController,
            ),
            TextFormField(
              obscureText: true,
              // keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(hintText: 'Password'),
              controller: _passwordController,
            ),
            SizedBox(height:10),
            ElevatedButton(onPressed: _save, child: Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}
