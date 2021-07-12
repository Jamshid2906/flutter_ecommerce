import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/pages/categories/index.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';


class CategoryCreate extends StatefulWidget {
  CategoryCreate({Key? key}) : super(key: key);
  @override
  _CategoryCreateState createState() => _CategoryCreateState();
}

class _CategoryCreateState extends State<CategoryCreate> {
  TextEditingController name_controller = TextEditingController();

  void save() {
    CategoryController user = CategoryController();
    Map a = {
      'username'  : name_controller.text,
      'created_at': FieldValue.serverTimestamp()
    };
    user.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryIndex()));
        setState(() {
          
        });
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
              controller: name_controller,
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
