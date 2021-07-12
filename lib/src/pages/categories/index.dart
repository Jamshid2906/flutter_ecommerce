import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/CategoryController.dart';
import 'package:flutter_ecommerce/src/pages/categories/create.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';

class CategoryIndex extends StatefulWidget {
  CategoryIndex({Key? key}) : super(key: key);

  @override
  _CategoryIndexState createState() => _CategoryIndexState();
}

class _CategoryIndexState extends State<CategoryIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories List'),
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: FutureBuilder<List?>(
        future: CategoryController().index(),
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
                  subtitle: Text('Create at ${snapshot.data![index]['created_at']}'),
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
              context, MaterialPageRoute(builder: (context) => CategoryCreate()));
        },
      ),
    );
  }
}
