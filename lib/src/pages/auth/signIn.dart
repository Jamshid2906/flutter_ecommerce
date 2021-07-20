import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/AuthController.dart';
import 'package:flutter_ecommerce/src/pages/auth/signUp.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _save() {
    Map<String, dynamic> request = {
      'email': _emailController.text,
      'password': _passwordController.text
    };

    AuthController().signIn(request).then((value) {
      print('Auth sign in');
      print(value);
      if (value == "in") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Sign In',
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: _save, child: Text('Sign In')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text('Sign Up')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
