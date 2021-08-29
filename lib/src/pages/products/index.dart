import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/ProductController.dart';
import 'package:flutter_ecommerce/src/app/providers/ProductProvider.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:flutter_ecommerce/src/pages/products/create.dart';
import 'package:flutter_ecommerce/src/pages/products/edit.dart';
import 'package:provider/provider.dart';

class ProductIndex extends StatefulWidget {
  ProductIndex({Key? key}) : super(key: key);

  static Widget screen() => ChangeNotifierProvider(
        create: (context) => ProductProvider(),
        builder: (context, child) => ProductIndex(),
      );

  @override
  _ProductIndexState createState() => _ProductIndexState();
}

class _ProductIndexState extends State<ProductIndex> {
  @override
  Widget build(BuildContext context) {
    final value = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products List'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: FutureBuilder<List?>(
        future: ProductController().index(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data);
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductEdit(id:snapshot.data![index].id).screen()));
                  },
                  // tileColor:Colors.red,
                  subtitle: Text('Price ${snapshot.data![index]['price']}'),
                  leading: Icon(Icons.production_quantity_limits_sharp),
                  title: Text(snapshot.data![index]['name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete Item'),
                              content: Text('Are you sure to delete item?'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () {
                                      value.delete(
                                          snapshot.data![index].id, context);
                                    },
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductCreate.screen()));
        },
      ),
    );
  }
}
