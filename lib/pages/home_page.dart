import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../controller/home_page_controller.dart';
import '../utils/app_colors.dart';

// Import statements

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18.sp),)),
        backgroundColor: ColorsForApp.headingPageColor,
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("User").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> userMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      String documentId = snapshot.data!.docs[index].id; // Get document ID
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: ${userMap['Email']}"),
                                SizedBox(height: 5),
                                Text("Name: ${userMap['name']}"),
                                SizedBox(height: 5),
                                Text("Password: ${userMap['Pass']}"),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        homePageController.deleteUser(documentId);
                                      },
                                      child: Container(
                                        child: Icon(Icons.delete, color: ColorsForApp.headingPageColor,size: 25.sp,),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: () {
                                        _showEditDialog(context, documentId, userMap['Email'], userMap['name'], userMap['Pass']);
                                      },
                                      child: Container(
                                        child: Icon(Icons.edit, color: ColorsForApp.headingPageColor,size: 25.sp,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("No Data"),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, String documentId, String currentEmail, String currentName, String currentPass) {
    final TextEditingController emailController = TextEditingController(text: currentEmail);
    final TextEditingController nameController = TextEditingController(text: currentName);
    final TextEditingController passController = TextEditingController(text: currentPass);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'New Email'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'New Name'),
              ),
              TextField(
                controller: passController,
                decoration: InputDecoration(labelText: 'New Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newEmail = emailController.text.trim();
                String newName = nameController.text.trim();
                String newPass = passController.text.trim();

                if (newEmail.isNotEmpty && newName.isNotEmpty && newPass.isNotEmpty) {
                  Map<String, dynamic> newData = {
                    'Email': newEmail,
                    'name': newName,
                    'Pass': newPass,
                  };
                  homePageController.updateUser(documentId, newData);
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
