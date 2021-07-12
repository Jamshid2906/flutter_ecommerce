import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/UserController.dart';
import 'package:flutter_ecommerce/src/pages/products/index.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';


class ProductCreate extends StatefulWidget {
  ProductCreate({Key? key}) : super(key: key);
  @override
  _ProductCreateState createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController price_controller = TextEditingController();
  TextEditingController desc_controller = TextEditingController();

  void save() {
    UserController user = UserController();
    Map a = {
      'name': name_controller.text,
      'price': price_controller.text,
      'desc': desc_controller.text,
    };
    user.store(a).then((value) {
      print(value);
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductIndex()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Add'),
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
            TextFormField(
              keyboardType: TextInputType.number,
              controller: price_controller,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              // textInputAction: TextInputAction.newline,
              maxLines: 5,
              controller: desc_controller, 
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
