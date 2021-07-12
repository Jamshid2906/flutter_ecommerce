import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/ProductController.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:flutter_ecommerce/src/pages/products/create.dart';

class ProductIndex extends StatefulWidget {
  ProductIndex({Key? key}) : super(key: key);

  @override
  _ProductIndexState createState() => _ProductIndexState();
}

class _ProductIndexState extends State<ProductIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products List'),
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
        }, icon: Icon(Icons.arrow_back_ios)),
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
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => UserEdit()));
                  },
                  // tileColor:Colors.red,
                  subtitle: Text('Price ${snapshot.data![index]['price']}'),
                  leading: Icon(Icons.favorite),
                  title: Text(snapshot.data![index]['name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    // onPressed: (){},
                    onPressed: () {},
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductCreate()));
        },
      ),
    );
  }
}
