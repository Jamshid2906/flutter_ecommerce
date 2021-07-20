import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/ProductController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/products/index.dart';


// ignore: must_be_immutable
class ProductEdit extends StatefulWidget {
  ProductEdit({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  // ignore: must_call_super
  void initState() {
    // ignore: todo
    // TODO: implement initState
    ProductController().edit(widget.id).then((value) {
      if(value != null){
        nameController.text  = value['name'];
        priceController.text = value['price'];
        descController.text  = value['desc'];
      }
    });
  }

  void _update() {
    Map a = {
      'name': nameController.text,
      'price': priceController.text,
      'desc': descController.text,
    };
    ProductController().update(a,widget.id).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductIndex()));
        SnackBarMessages.successSnackBar(context, 'Data updated successfully!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Edit'),
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
            TextFormField(
              keyboardType: TextInputType.number,
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              // textInputAction: TextInputAction.newline,
              maxLines: 5,
              controller: descController, 
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _update,
      ),
    );
  }
}
