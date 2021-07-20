import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/ProductController.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/messages/SnackbarMessages.dart';
import 'package:flutter_ecommerce/src/pages/products/index.dart';


class ProductCreate extends StatefulWidget {
  ProductCreate({Key? key}) : super(key: key);
  @override
  _ProductCreateState createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();

  void save() {
    ProductController product = ProductController();
    Map a = {
      'name': nameController.text,
      'price': priceController.text,
      'desc': descController.text,
    };
    product.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductIndex()));
        SnackBarMessages.successSnackBar(context, 'Data added successfully!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Add'),
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
        onPressed: save,
      ),
    );
  }
}
