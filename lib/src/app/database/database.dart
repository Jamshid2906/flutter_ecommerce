import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  late FirebaseFirestore firestore;
  
  Database(){
    this.firestore = FirebaseFirestore.instance;
  }

}