import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Changed import to use GetX

import 'package:quickensol/pages/home_page.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Create a user document in Firestore
      await _firestore.collection("User").doc(userCredential.user!.uid).set({
        'Email': emailController.text.toString(),
        'Pass': passwordController.text.toString(),
        'name': nameController.text.toString(),
      });

      // Navigate to HomePage after successful sign-up using GetX navigation
      Get.offAll(() => HomePage()); // Replaced Navigator.push with GetX navigation
    } catch (e) {
      print('Error during sign up: $e');
    }
  }

  void clearControllers() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
  }
}
