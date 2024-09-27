import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreService{

  FireStoreService._();

 static  FireStoreService fireStoreService = FireStoreService._();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
   Future<String> sendImage() async {
    ImagePicker imagePicker = ImagePicker();
  XFile? image = await  imagePicker.pickImage(source: ImageSource.gallery);
     final  ref = FirebaseStorage.instance.ref();
     final imageref =  ref.child("images/${image!.name}");
      await imageref.putFile(File(image.path));
      String url = await  imageref.getDownloadURL();
      return url;

   }



}