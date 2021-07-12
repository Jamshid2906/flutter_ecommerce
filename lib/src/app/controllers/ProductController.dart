import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/src/app/database/database.dart';

class ProductController {
  late Database db;

  /// ProductController consturctor
  /// @return void
  ProductController() {
    this.db = Database();
  }

  Future<List?> index() async {
    QuerySnapshot querySnapshot;
    querySnapshot = await db.firestore.collection('products').get();

    return querySnapshot.docs.toList();
  }

  Future store(Map request) async {
    Map<String, dynamic> data = {
      'name'  : request['name'],
      'price' : request['price'],
      'desc'  : request['desc'],
      'cat_id': request['cat_id']
    };

    return await db.firestore.collection('products').add(data);
  }

  Future update(Map request, String id) async {
    Map<String, dynamic> data = {
      'name' : request['name'],
      'price': request['price'],
      'desc' : request['desc'],
    };

    return await db.firestore.collection('products').doc(id).update(data);
  }
}
