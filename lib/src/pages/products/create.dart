import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/providers/ProductProvider.dart';
import 'package:flutter_ecommerce/src/app/services/FileService.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProductCreate extends StatefulWidget {
  ProductCreate({Key? key}) : super(key: key);
  @override
  _ProductCreateState createState() => _ProductCreateState();

  static Widget screen() => ChangeNotifierProvider(
      create: (_) => ProductProvider(), builder: (_, __) => ProductCreate());
}

class _ProductCreateState extends State<ProductCreate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    var dropdownValue = '';
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Product Add'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  DropdownButton(
                      items: <String>['Sneakers', 'Jacket', 'Watch', 'Fruniture','Clothes','T-shirt']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      }),
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                  onPressed: () {
                    selectFile();
                  },
                  child: Text('Some')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          productProvider.save(nameController.text, priceController.text,
              descController.text, context);
        },
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      final path = result.files.single.path!;
      setState(() {
        file = File(path);
      });
    }
  }

  Future uploadFile() async {
    if (file == null) return file;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    FileService.uploadFile(destination, file!);
  }
}
