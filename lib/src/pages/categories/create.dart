import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/categories/index.dart';


class CategoryCreate extends StatefulWidget {
  CategoryCreate({Key? key}) : super(key: key);
  @override
  _CategoryCreateState createState() => _CategoryCreateState();
}

class _CategoryCreateState extends State<CategoryCreate> {
  TextEditingController nameController = TextEditingController();

  void save() {
    CategoryController category = CategoryController();
    Map a = {
      'name'  : nameController.text,
      'created_at': FieldValue.serverTimestamp()
    };
    category.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryIndex()));
        SnackBarMessages.successSnackBar(context, 'Data added successfully!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Add'),
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new))
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
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
