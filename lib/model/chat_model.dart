import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class chatmodel extends GetxController{


  String? sender ,resiever,message,image;
       bool read;
  Timestamp? time;

  chatmodel({ required this.sender,required this.resiever,required this.message,required this.time,   this.read = false , required this.image});

   factory chatmodel.fromMap(Map  m1){
     return chatmodel(sender: m1['sender'], resiever: m1['resever'], message: m1['message'], time: m1['time'], read: m1['read']??false, image: m1['image']);
   }

   Map<String, Object?> toMap(chatmodel chat){
     return {
       'sender':chat.sender,
       'resever':chat.resiever,
       'message':chat.message,
       'time':chat.time,
       'read':chat.read,
       'image':chat.image,

     };
   }

}