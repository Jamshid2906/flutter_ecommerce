import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:flutter_ecommerce/src/pages/users/create.dart';
import 'package:flutter_ecommerce/src/pages/users/edit.dart';

class UserIndex extends StatefulWidget {
  UserIndex({Key? key}) : super(key: key);

  @override
  _UserIndexState createState() => _UserIndexState();
}

class _UserIndexState extends State<UserIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: FutureBuilder<List?>(
        future: UserController().index(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data);
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserEdit()));
                  },
                  // tileColor:Colors.red,
                  subtitle: Text('Phone ${snapshot.data![index]['phone']}'),
                  leading: Icon(Icons.favorite),
                  title: Text(snapshot.data![index]['username']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    // onPressed: (){},
                    onPressed: () {},
                  ),
                );
              },
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserCreate()));
        },
      ),
    );
  }
}
