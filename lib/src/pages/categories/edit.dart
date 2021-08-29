import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/app/providers/CategoryProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryEdit extends StatefulWidget {
  CategoryEdit({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  _CategoryEditState createState() => _CategoryEditState();
  Widget screen() => ChangeNotifierProvider(
        create: (context) => CategoryProvider(),
        builder: (context, child) => CategoryEdit(
          id: id,
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
            title: Text('Category Edit'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new))),
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
          onPressed: () {
            value.update(nameController.text, widget.id, context);
          },
        ),
      ),
    );
  }
}
