import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/categories/create.dart';
import 'package:flutter_ecommerce/src/pages/categories/edit.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:intl/intl.dart';

class CategoryIndex extends StatefulWidget {
  CategoryIndex({Key? key}) : super(key: key);

  @override
  _CategoryIndexState createState() => _CategoryIndexState();
}

class _CategoryIndexState extends State<CategoryIndex> {

  void _delete(String id){
    CategoryController().delete(id).then((value) {
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
        title: Text('Categories List'),
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
        }, icon: Icon(Icons.arrow_back_ios)),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CategoryEdit(id: snapshot.data![index].id)));
                  },
                  // tileColor:Colors.red,
                  subtitle: Text('Create at ${DateFormat('dd-MM-yyyy').format((snapshot.data![index]['created_at'] as Timestamp).toDate())}'),
                  leading: Icon(Icons.favorite),
                  title: Text(snapshot.data![index]['name']),
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
              context, MaterialPageRoute(builder: (context) => CategoryCreate()));
        },
      ),
    );
  }
}
