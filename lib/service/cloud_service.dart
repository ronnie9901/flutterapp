


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/chat_model.dart';
import '../model/userModel.dart';
import 'auth_service.dart';

class CloudFirestoreService {
  CloudFirestoreService._();

  static CloudFirestoreService cloudFirestoreService =
  CloudFirestoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<String> insertUser(UserModel user) async {
    try {
      await fireStore.collection("users").doc(user.email).set({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'img': user.img,
        'token': user.token,
        'read':user.read,
        'typing':user.typing,
        'isOnline':user.isOnline,
        'timestamp':user.timestamp,
      });
      return "success";
    } catch (e) {
      Get.snackbar('User not added in Firestore', e.toString());
      return e.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readDataUser() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection("users").where("email",isEqualTo: user!.email).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readDataAlldata() async {
    User? user = AuthService.authService.getCurrentUser();

    return await fireStore.collection("users").where("email",isNotEqualTo: user!.email).get();
  }

  Future<void> adddData(chatmodel chat) async {
    String? sender = chat.sender;
    String? resiever = chat.resiever;
    List doc = [sender, resiever];
    doc.sort();
    String docid = doc.join("-");
    await fireStore
        .collection('chatroom')
        .doc(docid)
        .collection('chat')
        .add(chat.toMap(chat));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readData(String resiever) {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, resiever];
    doc.sort();
    String docid = doc.join("-");
    return fireStore
        .collection("chatroom")
        .doc(docid)
        .collection("chat")
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future<void> updatechat(String message, String resiever, String dcid) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, resiever];
    doc.sort();
    String docid = doc.join("-");
    await fireStore
        .collection("chatroom")
        .doc(docid)
        .collection("chat")
        .doc(dcid)
        .update(
      {
        'message': message,
      },
    );
  }

  Future<void> deleteChat(String docId, String receiverEmail) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiverEmail];
    doc.sort();
    String docid = doc.join("-");
    try {
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(docid)
          .collection('chat')
          .doc(docId)
          .delete();
      print("Chat deleted successfully");
    } catch (e) {
      print("Failed to delete chat: $e");
    }
  }

  Future<void> updateReadStatus(String receiver, String dcId)  {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');

     return  fireStore
        .collection('chatroom')
        .doc(docId)
        .collection('chat')
        .doc(dcId)
        .update({'read': true});

  }

  Future<void> updateLastSeen() async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update({
      'timestamp': Timestamp.now(),
    });
  }


  Future<void> toggleOnlineStatus(bool status) async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update({
      'isOnline': status,
    });
  }

  Future<void> toggleTypingStatus(bool status) async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update({
      'typing': status,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> checkUserIsOnlineOrNot(
      String email) {
    return  fireStore.collection("users").doc(email).snapshots();

  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastChat(String receiver)  {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List<String> doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');

    return   fireStore
        .collection('chatroom')
        .doc(docId)
        .collection('chat')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }

}






