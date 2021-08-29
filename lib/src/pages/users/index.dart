import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/app/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class UserIndex extends StatefulWidget {
  UserIndex({Key? key}) : super(key: key);

  @override
  _UserIndexState createState() => _UserIndexState();

  static Widget screen() => ChangeNotifierProvider(
      create: (context) => UserProvider(),
      builder: (context, child) => UserIndex()
    );
}

class _UserIndexState extends State<UserIndex> {
  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        leading: IconButton(
            onPressed: () {
              userProvider.backMainScreen(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
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
                    userProvider.nextEditScreen(snapshot.data![index].id, context);
                  },
                  // tileColor:Colors.red,
                  subtitle: Text('Phone ${snapshot.data![index]['phone']}'),
                  leading: Icon(Icons.account_box),
                  title: Text(snapshot.data![index]['username']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete Item'),
                              content: Text('Are you sure to delete item?'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () {
                                      userProvider.delete(snapshot.data![index].id,context);
                                    },
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
          userProvider.nextCreateScreen(context);
        },
      ),
    );
  }
}
