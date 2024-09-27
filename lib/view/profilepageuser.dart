import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detailsScreen.dart';

class Profilepageuser extends StatelessWidget {
  final String img;
  final String name;
  final String email;

  const Profilepageuser({super.key, required this.img, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(CupertinoIcons.back)),
        title: Text('Profile Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: (img != null)
                      ? NetworkImage('${img}')
                      : (wallpaperController.fileImage.value != null)
                          ? FileImage(wallpaperController.fileImage.value!)
                          : AssetImage('assets/12.jpg'),
                  radius: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 103, left: 100),
                  child: GestureDetector(
                      onTap: () async {
                        await wallpaperController.selectWallpaper();
                      },
                      child: Icon(CupertinoIcons.camera_fill)),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              '${name} ',
              style: TextStyle(fontSize: 30),
            ),
            trailing: GestureDetector(onTap: () {}, child: Icon(Icons.edit)),
          ),
          ListTile(
            title: Text(
              '${email} ',
              style: TextStyle(fontSize: 20),
            ),
            trailing: GestureDetector(onTap: () {}, child: Icon(Icons.edit)),
          )
        ],
      ),
    );
  }
}
