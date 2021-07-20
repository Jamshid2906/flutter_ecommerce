import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/categories/index.dart';

// ignore: must_be_immutable
class CategoryEdit extends StatefulWidget {
  CategoryEdit({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  _CategoryEditState createState() => _CategoryEditState();

}

class _CategoryEditState extends State<CategoryEdit> {


  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    CategoryController().edit(widget.id).then((value) {
      nameController.text = value['name'];
    });
  }

  void _save(){
    CategoryController().update({
      'name'      : nameController.text,
      'created_at': Timestamp.fromDate(DateTime.now())
    }, widget.id).then((value) {
      print('before 34 34 34 ');
      print(value);
      if(value!=null){
        print('34 34 34 34 ');
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryIndex()));
        SnackBarMessages.successSnackBar(context, 'Data updated successfully!');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Edit'),
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
        onPressed: _save,
      ),
    );
  }
}