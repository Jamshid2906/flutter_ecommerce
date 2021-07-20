import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/src/app/database/database.dart';

class ProductController {
  late CollectionReference product;

  /// ProductController consturctor
  /// @return void
  ProductController() {
    this.product = Database().firestore.collection('products');
  }

  Future<List?> index() async {
    QuerySnapshot querySnapshot;
    querySnapshot = await product.get();

    return querySnapshot.docs.toList();
  }

  Future store(Map request) async {
    Map<String, dynamic> data = {
      'name'  : request['name'],
      'price' : request['price'],
      'desc'  : request['desc'],
      'cat_id': request['cat_id'] ?? 1
    };

    return await product.add(data);
  }

  Future update(Map request, String id) async {
    Map<String, dynamic> data = {
      'name' : request['name'],
      'price': request['price'],
      'desc' : request['desc'],
    };

    return await product.doc(id).update(data);
  }

  Future edit(String id) async {
    
    return await product.doc(id).get();
  }

  // Delete method
  Future delete(String id) async
  {
    await product.doc(id).delete();

    return true;
  }
}
