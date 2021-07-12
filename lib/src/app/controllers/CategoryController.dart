import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/src/app/database/database.dart';

class CategoryController {

  late Database db;

  CategoryController(){
    this.db = Database();
  }

  Future<List?> index() async {
    List? items;
    QuerySnapshot querySnapshot;
    querySnapshot =await db.firestore.collection('categories').get();
    if(querySnapshot.docs.isNotEmpty){
      for(var doc in querySnapshot.docs.toList()){
        items!.add({
          'name'       : doc['name'],
          'created_at' : doc['created_at'],
        });
      }
    }

    return items;
  }

  Future store(Map request) async{
    Map<String,dynamic> data = {
      'name'       : request['name'],
      'created_at' : request['created_at'],
    };

    return await db.firestore.collection('categories').add(data);
  }

  Future update(Map request, String id) async{
    Map<String,dynamic> data = {
      'name'       : request['name'],
      'created_at' : request['created_at'],
    };

    return await db.firestore.collection('categories').doc(id).update(data);
  }
}