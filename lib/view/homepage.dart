import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/userModel.dart';
import '../service/auth_service.dart';
import '../service/cloud_service.dart';
import 'detailsScreen.dart';
import 'profiile_page.dart';
import 'profilepageuser.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  @override
  String userId = AuthService.authService.getCurrentUser()!
      .email!; // Replace with actual user ID

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CloudFirestoreService.cloudFirestoreService.toggleOnlineStatus(
      true,
      // Timestamp.now(),
      // false,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      CloudFirestoreService.cloudFirestoreService.toggleOnlineStatus(false);
      CloudFirestoreService.cloudFirestoreService.updateLastSeen();
    } else if (state == AppLifecycleState.resumed) {
      CloudFirestoreService.cloudFirestoreService.toggleOnlineStatus(true);
      }
      // } else if (state == AppLifecycleState.inactive) {
      //   CloudFirestoreService.cloudFirestoreService.toggleOnlineStatus(
      //     false,
      //     Timestamp.now(),
      //     false,
      //   );
      // } else if (state == AppLifecycleState.hidden) {
      //   CloudFirestoreService.cloudFirestoreService.toggleOnlineStatus(
      //     false,
      //     Timestamp.now(),
      //     false,
      //   );
      // }


    // @override
    // void dispose() {
    //   super.dispose();
    //   WidgetsBinding.instance.removeObserver(this);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey, // Fixed color without dark mode logic
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chat,
                color: Colors.black, // Fixed color without dark mode logic
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Colors.black, // Fixed color without dark mode logic
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => ProfiilePage());
              },
              icon: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.black, // Fixed color without dark mode logic
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Message'),
        backgroundColor: Colors.brown.shade200, // Fixed color
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.authService.signout();
              User? user = AuthService.authService.getCurrentUser();
              if (user == null) {
                Get.offAndToNamed('/');
              }
            },
            icon: Icon(Icons.logout),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) {
              return [
                buildPopupMenuItem('Unread', Icons.markunread),
                buildPopupMenuItem('Contacts', Icons.contacts),
                buildPopupMenuItem('Non-Contacts', Icons.person_off),
                buildPopupMenuItem('Groups', Icons.group),
                buildPopupMenuItem('Drafts', Icons.drafts),
              ];
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: FutureBuilder(
        future: CloudFirestoreService.cloudFirestoreService.readDataAlldata(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List data = snapshot.data!.docs;
          List<UserModel> userList = [];

          for (var user in data) {
            userList.add(UserModel.fromMap(user.data()));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  style: TextStyle(fontSize: 10),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: (Icon(Icons.search)),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.mic_fill),
                    ),
                    label: Text('Search'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Get.to(() =>
                                  Profilepageuser(
                                    img: userList[index].img!,
                                    name: userList[index].name!,
                                    email: userList[index].email!,
                                  ));
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${userList[index].img}'),
                              radius: 25,
                            ),
                          ),
                          title: Text(
                            '${userList[index].name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Fixed color
                            ),
                          ),
                          subtitle: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: CloudFirestoreService
                                .cloudFirestoreService.getLastChat(
                                chatController.receiveremail.value),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text('Loading...');
                              }

                              var chatDocs = snapshot.data!.docs;

                              if (chatDocs.isEmpty) {
                                return Text('No messages yet');
                              }

                              var lastMessage = chatDocs.first.data();
                              return Text(lastMessage['message'].toString());
                            },
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('12:00',
                                  style: TextStyle(color: Colors.grey)),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            chatController.getReceiver(
                              userList[index].email!,
                              userList[index].name!,
                            );
                            Get.to(() =>
                                ChatDetailScreen(img: userList[index].img));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

PopupMenuItem<String> buildPopupMenuItem(String title, IconData icon) {
  return PopupMenuItem(
    value: title,
    child: Row(
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(width: 10),
        Text(title),
      ],
    ),
  );
}