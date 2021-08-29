
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/app/providers/CategoryProvider.dart';
import 'package:flutter_ecommerce/src/pages/categories/create.dart';
import 'package:flutter_ecommerce/src/pages/categories/edit.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryIndex extends StatefulWidget {
  static Widget screen() => ChangeNotifierProvider(
        create: (context) => CategoryProvider(),
        builder: (context, child) => CategoryIndex(),
      );

  CategoryIndex({Key? key}) : super(key: key);

  @override
  _CategoryIndexState createState() => _CategoryIndexState();
}

class _CategoryIndexState extends State<CategoryIndex> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context,value,child) => Scaffold(
        appBar: AppBar(
          title: Text('Categories List'),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MainPage()));
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: FutureBuilder<List?>(
          future: CategoryController().index(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data);
                  print(snapshot.data![index].id);
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryEdit(id: snapshot.data![index].id).screen()));
                    },
                    // tileColor:Colors.red,
                    subtitle: Text(
                        'Create at ${DateFormat('dd-MM-yyyy').format((snapshot.data![index]['created_at'] as Timestamp).toDate())}'),
                    leading: Icon(Icons.favorite),
                    title: Text(snapshot.data![index]['name']),
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
                                      onPressed: (){
                                        value.delete(snapshot.data![index].id, context);
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryCreate.screen()));
          },
        ),
      ),
    );
  }
}
