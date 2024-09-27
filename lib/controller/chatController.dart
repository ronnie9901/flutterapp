

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../service/cloud_service.dart';
class ChatController extends GetxController{


  RxString  receiveremail = "".obs;
  RxString  image = "".obs;
  RxString  receivername = "".obs;
  RxString receiverImageUrl = ''.obs;
  RxString messageStore = ''.obs;
  RxBool check= false.obs;
  RxList docIdList = [].obs;
  RxInt docIndex = 0.obs;

  var docIdToUpdateMessage = '';

  TextEditingController txtmessage= TextEditingController();


void setImage(String url){

  image.value = url;


}

  void getReceiver( String email,String  name){

    receivername.value = name;
    receiveremail.value =email;
  }

  void changeUpdateMessage(int index)
  {
    check.value = true;
    docIndex = index.obs;
  }

  void setFalseUpdate()
  {
    check.value = false;
  }


  void getDocIdList(List docList){
    docIdList.value = docList;
  }

 // @override
 //  void onInit() {
 //    // TODO: implement onInit
 //    super.onInit();
 //
 //    CloudFirestoreService.cloudFirestoreService.updateIsOnline(true);
 //  }
 //  @override
 //  void onClose() {
 //    // TODO: implement onClose
 //    super.onClose();
 //    CloudFirestoreService.cloudFirestoreService.updateIsOnline(false);
 //
 //  }


}