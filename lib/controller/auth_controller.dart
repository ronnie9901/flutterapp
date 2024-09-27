
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{


  TextEditingController txtemail =TextEditingController();
  TextEditingController txtpassword =TextEditingController();
  TextEditingController txtconpassword =TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtPhone =TextEditingController();

  GlobalKey<FormState> fromkey =GlobalKey();

  RxBool chack = true.obs;

  void chck(){

    if(chack.value){
      chack.value = false;
     Icons.visibility_off;
    }
    else{
      chack.value = true;
    Icons.remove_red_eye;
    }
  }



}
