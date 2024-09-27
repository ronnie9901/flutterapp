
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/sign_in.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/userModel.dart';
import '../service/auth_service.dart';
import '../service/cloud_service.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.fromkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email or Phone is required';
                  }
                },
                controller: controller.txtname,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: (Icon(Icons.person)),
                    label: Text('UserName'),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email or Phone is required';
                  }
                  if (!value.contains('@gmail.com')) {
                    return 'Must Be Enter @gmail.com';
                  }
                  if (value.contains(' ')) {
                    return 'Do not enter the sapce';
                  }
                  if (RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Entre the must be lowercase requried';
                  }
                  if (value.toString() == '@gmail.com') {
                    return 'emaple : abc@gmail.com';
                  }
                },
                controller: controller.txtemail,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: (Icon(CupertinoIcons.person)),
                    label: Text('email'),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'example Abc@1234';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'example Abc@1234';
                  }
                  if (!RegExp(r'\d').hasMatch(value)) {
                    return 'example Abc@1234';
                  }
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'example Abc@1234';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                controller: controller.txtpassword,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: (Icon(Icons.lock)),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(CupertinoIcons.eye)),
                    label: Text('password'),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.txtconpassword,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: (Icon(Icons.lock)),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(CupertinoIcons.eye)),
                    label: Text('Comfirm Passawaed'),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ))),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed('/');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          '                       already you gave  Account ?'),
                      Text(
                        '  Sign-In',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  )),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  bool res = controller.fromkey.currentState!.validate();

                  if (res) {
                    if (controller.txtpassword.text ==
                        controller.txtconpassword.text) {

                      UserModel user = UserModel(
                        isOnline: null,
                        name: controller.txtname.text,
                        email: controller.txtemail.text,
                        img:
                            'https://st3.depositphotos.com/3538469/15750/i/450/depositphotos_157501024-stock-photo-business-man-icon.jpg',
                        phone: controller.txtPhone.text,
                        token: '', typing: false, timestamp: Timestamp.now(), read: false,
                      );

                      String status = await AuthService.authService.creatUser(
                          controller.txtemail.text,
                          controller.txtpassword.text);

                      String cloudStatus = await CloudFirestoreService.cloudFirestoreService
                          .insertUser(user);

                      if(status=="success" && cloudStatus=="success"){
                        Get.offAndToNamed('/home');
                      }

                      controller.txtpassword.clear();
                      controller.txtemail.clear();
                      controller.txtPhone.clear();
                      
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Sign-Up ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
