import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/userModel.dart';
import '../service/auth_service.dart';
import '../service/cloud_service.dart';
import 'detailsScreen.dart';

class ProfiilePage extends StatelessWidget {
  const ProfiilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),

      body: FutureBuilder(
        future: CloudFirestoreService.cloudFirestoreService.readDataUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot!.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // List data = snapshot.data!.docs;
          // UserModel userModel = UserModel.fromMap(data);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                           NetworkImage('${AuthService.authService.getCurrentUser()!.photoURL}'),
            
                      radius: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 103, left: 100),
                      child: GestureDetector(
                          onTap: () async {
                            await wallpaperController.selectWallpaper();
                          },
                          child: Icon(CupertinoIcons.camera_fill,color: Colors.white,)),
                    ),
                  ],
                ),),
                ListTile(
                  title: Text('${AuthService.authService.getCurrentUser()!.email!}',
                    style: TextStyle(fontSize: 18, ),
                  ),
                ),
            
                SettingsTile(icon: Icons.vpn_key, title: 'Account', subtitle: 'Security notifications, change number'),
                SettingsTile(icon: Icons.lock, title: 'Privacy', subtitle: 'Block contacts, disappearing messages'),
                SettingsTile(icon: Icons.icecream_outlined, title: 'Theme', subtitle: 'Light Theme,  Dark Theme'),
                SettingsTile(icon: Icons.favorite, title: 'Favourites', subtitle: 'Add, reorder, remove'),
                SettingsTile(icon: Icons.chat, title: 'Chats', subtitle: 'Theme, wallpapers, chat history'),
                SettingsTile(icon: Icons.notifications, title: 'Notifications', subtitle: 'Message, group & call tones'),
                SettingsTile(icon: Icons.data_usage, title: 'Storage and data', subtitle: 'Network usage, auto-download'),
                SettingsTile(icon: Icons.language, title: 'App language', subtitle: 'English (device\'s language)'),
                SettingsTile(icon: Icons.language, title: 'App language', subtitle: 'English (device\'s language)'),


            
              ],
            ),
          );
        },
      ),
    );
  }

  ListTile SettingsTile({required IconData icon,
    required String title,
    required String subtitle}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),

    );
  }
}
// ListTile(
// leading: const Icon(
// Icons.logout,
// color: Colors.white,
// size: 25,
// ),
// title: InkWell(
// onTap: () async {
// await AuthService.authService.signout();
// User? user = AuthService.authService.getCurrentUser();
// if (user == null) {
// Get.offAndToNamed('/');
// }
// },
// child: const Text(
// 'Logout',
// style: TextStyle(fontSize: 18, color: Colors.white70),
// ),
// ),
// ),
