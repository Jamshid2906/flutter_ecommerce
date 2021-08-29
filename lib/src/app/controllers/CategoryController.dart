import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/src/app/database/database.dart';
import 'package:flutter_ecommerce/src/model/category.dart';

class CategoryController {

  late CollectionReference category;

  CategoryController(){
    this.category = Database().firestore.collection('categories');
  }

  Future<List<Category>> index() async {
    QuerySnapshot querySnapshot;
    querySnapshot = await category.get();
    List<Category> categories = querySnapshot.docs.map((value) {
      return Category(name: value['name'], image: '');
    }).toList();

    return categories;
    // if(querySnapshot.docs.isNotEmpty){
    //   return querySnapshot.docs.toList();
    // }
  }

  Future store(Map request) async{
    Map<String,dynamic> data = {
      'name'       : request['name'],
      'created_at' : request['created_at'],
    };

    return await category.add(data);
  }

  Future update(Map request, String id) async{
    Map<String,dynamic> data = {
      'name'       : request['name'],
      'created_at' : request['created_at'],
    };
    print('Controller 34 34 34 ');
    var update =  category.doc(id).set(data);
    return update;
  }

  // Edit method
  Future edit(String id) async {

    return await category.doc(id).get();
  }

  // Delete method
  Future delete(String id) async
  {
    await category.doc(id).delete();

    return true;
  }
}