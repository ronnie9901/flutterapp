import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../controller/auth_controller.dart';
import '../service/auth_service.dart';
import '../service/google_auth_service.dart';
var controller = Get.put(AuthController());

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        // Adjust padding based on screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller.txtemail,
              style: TextStyle(fontSize: screenSize.width * 0.04),
              // Adjust font size
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
              height: screenSize.height * 0.03, // Adjust spacing
            ),
            Obx(
              () => TextFormField(
                obscureText: controller.chack.value,
                controller: controller.txtpassword,
                style: TextStyle(fontSize: screenSize.width * 0.04),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: (Icon(Icons.lock)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.chck();
                        },
                        icon: Icon(CupertinoIcons.eye)),
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
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [

                GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(' Reset password'),
                          actions: [
                            TextField(decoration: InputDecoration(label: Text('email ')),),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {}, child: Text('Send ')),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    }, child: Text('cancel '))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    child: Text(' Forget passward ?',style: TextStyle(fontSize: 15,color: Colors.grey),))
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.05, // Adjust spacing
            ),
            GestureDetector(
              onTap: () async {
                String response = await AuthService.authService.signIn(
                    controller.txtemail.text, controller.txtpassword.text);

                User? user = AuthService.authService.getCurrentUser();
                if (user != null && response == 'success') {
                  Get.offAndToNamed('/home');
                } else {
                  Get.snackbar('Sign In  faild', response);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 46,
                  width: screenSize.width * 0.9,
                  // Adjust button width
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Sign-In ',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, letterSpacing: 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Center(child: Text('OR')),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Container(
              height: 50,
              width: screenSize.width * 0.8,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              // Adjust width for Google Sign-In button
              child: SignInButton(Buttons.google, onPressed: () async {
                // try{
                  await GoogleAuth.googleAuth.signUpUsingGoogle();
                  User? user = AuthService.authService.getCurrentUser();

                  if (user != null) {
                    Get.offAndToNamed('/home');
                  }
                  // else {
                  //   Get.snackbar('Sign In  faild', '');
                  // }
                // }catch(e){
                //   print('$e');
                // }
              }),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed('/signup');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an Account?',
                        style: TextStyle(color: Colors.grey)),
                    Text(
                      ' Signup',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
