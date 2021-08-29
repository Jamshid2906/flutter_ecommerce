import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/providers/CategoryProvider.dart';
import 'package:provider/provider.dart';


class CategoryCreate extends StatefulWidget {
  CategoryCreate({Key? key}) : super(key: key);
  @override
  _CategoryCreateState createState() => _CategoryCreateState();

  static Widget screen() => ChangeNotifierProvider(
        create: (context) => CategoryProvider(),
        builder: (context, child) => CategoryCreate(),
      );

}

class _CategoryCreateState extends State<CategoryCreate> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context,value,child) => Scaffold(
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
          onPressed: (){
            value.save(nameController.text,context);
          },
        ),
      ),
    );
  }
}
