import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/src/app/database/database.dart';
class UserController{
  late CollectionReference user;

  UserController(){
    this.user = new Database().firestore.collection('users');
  }
  Future<List?> index() async{
    QuerySnapshot? querySnapshot;
    querySnapshot = await user.orderBy('username').get();

    return querySnapshot.docs.toList();
  }

  Future store(Map request) async {
    Map<String,dynamic> data = {
      'username' : request['username'],
      'phone'    : request['phone'], 
      'password' : request['password'] 
    };

    return await user.add(data);
  }

  Future update(Map request, String id) async {
    return await user.doc(id).update({
      'username' : request['username'],
      'phone'    : request['phone'], 
      'password' : request['password']
    });
  }

  Future edit(String id) async{
    
    return await user.doc(id).get();
  }

  // Delete method
  Future delete(String id) async
  {
    await user.doc(id).delete();

    return true;
  }

}