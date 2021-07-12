import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/src/app/database/database.dart';
class UserController{
  late Database db;

  UserController(){
    this.db = new Database();
  }
  Future<List?> index() async{
    QuerySnapshot? querySnapshot;
    List docs = [];
      querySnapshot = await db.firestore.collection('users').orderBy('username').get();
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList()){
          print(doc.runtimeType);
          Map<String,dynamic> a = {
            'id': doc.id,
            'username': doc['username'],
            'phone':doc['phone']
          };
          docs.add(a);
        }
        return docs;
      }
  }

  Future store(Map request) async {
    Map<String,dynamic> data = {
      'username' : request['username'],
      'phone'    : request['phone'], 
      'password' : request['password'] 
    };

    return await db.firestore.collection('users').add(data);
  }

  Future update(Map request, String id) async {
    return await db.firestore.collection('users').doc(id).update({
      'username' : request['username'],
      'phone'    : request['phone'], 
      'password' : request['password']
    });
  }

}