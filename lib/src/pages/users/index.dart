import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/AuthController.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:flutter_ecommerce/src/pages/users/create.dart';
import 'package:flutter_ecommerce/src/pages/users/edit.dart';

class UserIndex extends StatefulWidget {
  UserIndex({Key? key}) : super(key: key);

  @override
  _UserIndexState createState() => _UserIndexState();
}

class _UserIndexState extends State<UserIndex> {

  void _delete(String id){
    UserController().delete(id).then((value) {
      if(value == true) {
        SnackBarMessages.successSnackBar(context, 'Item Deleted successfullty!');
        Navigator.pop(context);
        setState(() {
          
        });
      }
    });
  }
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
                        MaterialPageRoute(builder: (context) => UserEdit(id: snapshot.data![index].id,)));
                  },
                  // tileColor:Colors.red,
                  subtitle: Text('Phone ${snapshot.data![index]['phone']}'),
                  leading: Icon(Icons.account_box),
                  title: Text(snapshot.data![index]['username']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                   onPressed: () {
                      showDialog(context: context, builder: (context){  
                        return AlertDialog(
                          title: Text('Delete Item'),
                          content: Text('Are you sure to delete item?'),
                          actions: [
                            ElevatedButton(onPressed: (){}, child: Text('Cancel')),
                            ElevatedButton(onPressed: (){_delete(snapshot.data![index].id);}, 
                            child: Text('Coniform')),
                          ],
                        );
                      });
                    },
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
